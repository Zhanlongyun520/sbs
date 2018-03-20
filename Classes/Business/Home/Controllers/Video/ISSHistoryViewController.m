//
//  ISSHistoryViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSHistoryViewController.h"
#import "ActionSheetDatePicker.h"
#import "UVQueryCondition.h"
#import "UVQueryReplayParam.h"
#import "UVRecordInfo.h"
#import "UVStartReplayParam.h"
#import "LoadingManager.h"
#import "ISSVideoPhotoManager.h"
#import "UVPlayerDelegate.h"
#import "ISSCameraManager.h"
#import "Masonry.h"

@interface ISSHistoryViewController () <UVPlayerDelegate>
{
    UILabel     * starTimeDataLabel;
    UILabel     * endTimeDataLabel;
    UILabel     * endTimeLabel;
    UILabel     * starTimeLabel;
    
    NSDate *_startDate;
    NSDate *_endDate;
    
    UIButton *_playButton1;
    UIButton *_playButton2;
    
    UIView *_playerControlView;
    UIButton *_pauseButton;
    UIButton *_fullscreenButton;
    UISlider *_slider;
    
    UVUtils *_utils;
    
    UVRecordInfo *_recordInfo;
    NSString *_replaySession;
    
    UVStreamPlayer *_player;
    
    UIView *_playerView;
    UIImageView *_playerImageView;
    
    NSTimer *_timer;
}

@end

@implementation ISSHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHiddenTabBar = YES;
    
    self.title = @"历史监控";
    
    [self setUI];
    
    _endDate = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd 00:00:00";
    NSString *sDate = [formatter stringFromDate:_endDate];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    _startDate = [formatter dateFromString:sDate];
    
    [self showStartTime];
    [self showEndTime];
    
    _utils = [[UVUtils alloc] init];
    _player = [[UVStreamPlayer alloc] initWithDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [super viewWillDisappear:animated];
}

- (void)backBarButton:(UIButton *)btn{
    NSString *session = _player.playSession;
    if (session) {
        [_player AVStopPlay];
        [[ISSCameraManager shareInstance].request execRequest:^{
            [[ISSCameraManager shareInstance].service stopReplay:session];
        } finish:^(UVError *error) {
            [_timer invalidate];
            [self showReplaySlider:NO];
            _recordInfo = nil;
            _replaySession = nil;
            
            [self replayStopped];
        }];
    }
    
    [super backBarButton:btn];
}

- (void)setUI
{
    UIImageView  *playIV = [[UIImageView alloc]initForAutoLayout];
    playIV.backgroundColor = ISSColorBlack;
    [self.view addSubview:playIV];
    [playIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@(kScreenWidth * (9.0 / 16.0)));
    }];
    
    _playerView = [[UIView alloc] init];
    _playerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth * (9.0 / 16.0));
    [self.view addSubview:_playerView];
    
    _playerImageView = [[UIImageView alloc] init];
    _playerImageView.frame = _playerView.bounds;
    _playerImageView.image = [UIImage imageNamed:@"video-small-bg"];
    [_playerView addSubview:_playerImageView];
    
    UIButton * playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.translatesAutoresizingMaskIntoConstraints = NO;
    [playButton setImage:[UIImage imageNamed:@"bigpaly"]  forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(doReplay) forControlEvents:UIControlEventTouchUpInside];
    [_playerView addSubview:playButton];
    [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_playerView);
        make.width.height.equalTo(@44);
    }];
    _playButton1 = playButton;
    
    _playerControlView = [[UIView alloc] init];
    _playerControlView.frame = _playerView.bounds;
    _playerControlView.hidden = YES;
    [_playerView addSubview:_playerControlView];
    
    _pauseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _pauseButton.tintColor = [UIColor whiteColor];
    _pauseButton.tag = 0;
    [_pauseButton setImage:[UIImage imageNamed:@"litplay"] forState:UIControlStateNormal];
    [_pauseButton addTarget:self action:@selector(pauseClicked) forControlEvents:UIControlEventTouchUpInside];
    [_playerControlView addSubview:_pauseButton];
    [_pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@44);
        make.left.bottom.equalTo(@0);
    }];
    
    _fullscreenButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _fullscreenButton.tintColor = [UIColor whiteColor];
    _fullscreenButton.tag = 0;
    [_fullscreenButton setImage:[UIImage imageNamed:@"fullscreen"] forState:UIControlStateNormal];
    [_fullscreenButton addTarget:self action:@selector(fullClicked) forControlEvents:UIControlEventTouchUpInside];
    [_playerControlView addSubview:_fullscreenButton];
    [_fullscreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(_pauseButton);
        make.right.bottom.equalTo(@0);
    }];
    
    _slider = [[UISlider alloc] init];
    [_slider setThumbImage:[UIImage imageNamed:@"slidicon"] forState:UIControlStateNormal];
    [_playerControlView addSubview:_slider];
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_pauseButton);
        make.left.equalTo(_pauseButton.mas_right);
        make.right.equalTo(_fullscreenButton.mas_left);
    }];
    
    
    UIView * cellBG1 = [[UIView alloc]initForAutoLayout];
    cellBG1.backgroundColor = ISSColorViewBg1;
    [self.view addSubview:cellBG1];
    [self.view addConstraints:[cellBG1 constraintsSize:CGSizeMake(kScreenWidth - 32, 44)]];
    [self.view addConstraints:[cellBG1 constraintsTop:10 FromView:playIV]];
    [self.view addConstraints:[cellBG1 constraintsLeftInContainer:16]];
    
    UIView * cellBG = [[UIView alloc]initForAutoLayout];
    cellBG.backgroundColor = ISSColorWhite;
    [self.view addSubview:cellBG];
    [self.view addConstraints:[cellBG constraintsSize:CGSizeMake(kScreenWidth - 32, 54)]];
    [self.view addConstraints:[cellBG constraintsTop:0 FromView:cellBG1]];
    [self.view addConstraints:[cellBG constraintsLeftInContainer:16]];
    
    UILabel * nameLabel = [[UILabel alloc]initForAutoLayout];
    nameLabel.font = ISSFont12;
    nameLabel.textColor = ISSColorDardGray9;
    nameLabel.text = @"设备编号:";
    [self.view addSubview:nameLabel];
    [self.view addConstraints:[nameLabel constraintsTop:26 FromView:playIV]];
    [self.view addConstraints:[nameLabel constraintsLeftInContainer:32]];
    
    UILabel * numLabel = [[UILabel alloc]initForAutoLayout];
    numLabel.font = ISSFont14;
    numLabel.textColor = ISSColorDardGray2;
    numLabel.text = _listModel.deviceCoding;
    [self.view addSubview:numLabel];
    [self.view addConstraints:[numLabel constraintsTop:24 FromView:playIV]];
    [self.view addConstraints:[numLabel constraintsLeft:1 FromView:nameLabel]];
    
    UIImageView * onlineIV = [[UIImageView alloc]initForAutoLayout];
    [self.view addSubview:onlineIV];
    [self.view addConstraints:[onlineIV constraintsSize:CGSizeMake(28, 14)]];
    [self.view addConstraints:[onlineIV constraintsTop:25 FromView:playIV]];
    [self.view addConstraints:[onlineIV constraintsLeft:5 FromView:numLabel]];
    if ([_listModel.deviceStatus isEqualToString:@"0"]) {
        onlineIV.image = [UIImage imageNamed:@"online"];
    } else if ([_listModel.deviceStatus isEqualToString:@"1"]) {
        onlineIV.image = [UIImage imageNamed:@"offline"];
    } else if ([_listModel.deviceStatus isEqualToString:@"2"]) {
        onlineIV.image = [UIImage imageNamed:@"breakdown"];
    }
    
    UILabel * timeLabel = [[UILabel alloc]initForAutoLayout];
    timeLabel.font = ISSFont12;
    timeLabel.textColor = ISSColorDardGray9;
//    timeLabel.text = @"安装日期：2017-08-09";
    [self.view addSubview:timeLabel];
    [self.view addConstraints:[timeLabel constraintsTop:26 FromView:playIV]];
    [self.view addConstraints:[timeLabel constraintsRightInContainer:32]];
    
    UIImageView * logoIV = [[UIImageView alloc]initForAutoLayout];
    logoIV.image = [UIImage imageNamed:@"site"];
    [self.view addSubview:logoIV];
    [self.view addConstraints:[logoIV constraintsTop:33 FromView:nameLabel]];
    [self.view addConstraints:[logoIV constraintsLeftInContainer:32]];
    
    UILabel * addressLabel = [[UILabel alloc]initForAutoLayout];
    addressLabel.font = ISSFont14;
    addressLabel.textColor = ISSColorDardGray2;
    addressLabel.text = _listModel.deviceCoding;
    [self.view addSubview:addressLabel];
    [self.view addConstraints:[addressLabel constraintsTop:31 FromView:nameLabel]];
    [self.view addConstraints:[addressLabel constraintsLeft:4 FromView:logoIV]];
    
    UIImageView * litarrowIV = [[UIImageView alloc]initForAutoLayout];
    litarrowIV.image = [UIImage imageNamed:@"litarrow"];
    [self.view addSubview:litarrowIV];
    [self.view addConstraints:[litarrowIV constraintsTop:34 FromView:nameLabel]];
    [self.view addConstraints:[litarrowIV constraintsRightInContainer:32]];
    
    UIView * cellBG2 = [[UIView alloc]initForAutoLayout];
    cellBG2.backgroundColor = ISSColorWhite;
    [self.view addSubview:cellBG2];
    [self.view addConstraints:[cellBG2 constraintsSize:CGSizeMake(kScreenWidth - 32, 150)]];
    [self.view addConstraints:[cellBG2 constraintsTop:10 FromView:cellBG]];
    [self.view addConstraints:[cellBG2 constraintsLeftInContainer:16]];
    
    UILabel * choiceLabel = [[UILabel alloc]initForAutoLayout];
    choiceLabel.font = ISSFont14;
    choiceLabel.textColor = ISSColorDardGray6;
    choiceLabel.text = @"选择时段播放";
    [self.view addSubview:choiceLabel];
    [self.view addConstraints:[choiceLabel constraintsBottom: -30 FromView:cellBG2]];
    [self.view addConstraints:[choiceLabel constraintsLeftInContainer:32]];
    
    UIButton * starPlayButton = [UIButton buttonWithType:UIButtonTypeSystem];
    starPlayButton.translatesAutoresizingMaskIntoConstraints = NO;
    [starPlayButton setTitle:@"播放" forState:UIControlStateNormal];
    [starPlayButton addTarget:self action:@selector(doReplay) forControlEvents:UIControlEventTouchUpInside];
    _playButton2 = starPlayButton;
    starPlayButton.titleLabel.font = ISSFont14;
    [starPlayButton setTintColor:ISSColorNavigationBar];
    starPlayButton.layer.borderColor = [ISSColorNavigationBar CGColor];
    starPlayButton.layer.borderWidth = 0.5f;
    starPlayButton.layer.masksToBounds = YES;
    starPlayButton.layer.cornerRadius = 5;
    [self.view addSubview:starPlayButton];
    [self.view addConstraints:[starPlayButton constraintsSize:CGSizeMake(48, 24)]];
    [self.view addConstraints:[starPlayButton constraintsBottom: -36 FromView:cellBG2]];
    [self.view addConstraints:[starPlayButton constraintsRightInContainer:60]];
    
    UIImageView * bottomLine = [[UIImageView alloc]initForAutoLayout];
    bottomLine.backgroundColor = ISSColorSeparatorLine;
    [self.view addSubview:bottomLine];
    [self.view addConstraints:[bottomLine constraintsSize:CGSizeMake(kScreenWidth - 64, 0.5)]];
    [self.view addConstraints:[bottomLine constraintsBottom: -50 FromView:cellBG2]];
    [self.view addConstraints:[bottomLine constraintsLeftInContainer:32]];
    
    UILabel * starLabel = [[UILabel alloc]initForAutoLayout];
    starLabel.font = ISSFont12;
    starLabel.textColor = ISSColorDardGray9;
    starLabel.text = @"开始";
    [self.view addSubview:starLabel];
    [self.view addConstraints:[starLabel constraintsTop:20 FromView:bottomLine]];
    [self.view addConstraints:[starLabel constraintsLeftInContainer:32]];
    
    starTimeDataLabel = [[UILabel alloc]initForAutoLayout];
    starTimeDataLabel.font = ISSFont12;
    starTimeDataLabel.textColor = ISSColorDardGray2;
    starTimeDataLabel.text = @"2017-11-15";
    [self.view addSubview:starTimeDataLabel];
    [self.view addConstraints:[starTimeDataLabel constraintsTop:20 FromView:starLabel]];
    [self.view addConstraints:[starTimeDataLabel constraintsLeftInContainer:32]];

    starTimeLabel = [[UILabel alloc]initForAutoLayout];
    starTimeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    starTimeLabel.textColor = ISSColorDardGray2;
    starTimeLabel.text = @"12:25:00";
    [self.view addSubview:starTimeLabel];
    [self.view addConstraints:[starTimeLabel constraintsTop:0 FromView:starTimeDataLabel]];
    [self.view addConstraints:[starTimeLabel constraintsLeftInContainer:32]];
    
    UIImageView * verticalLine = [[UIImageView alloc]initForAutoLayout];
    verticalLine.backgroundColor = ISSColorSeparatorLine;
    [self.view addSubview:verticalLine];
    [self.view addConstraints:[verticalLine constraintsSize:CGSizeMake(0.5, 64)]];
    [self.view addConstraints:[verticalLine constraintsTop:20 FromView:bottomLine]];
    [self.view addConstraint:[verticalLine constraintCenterXInContainer]];
    
    UIImageView * starLitarrowIV = [[UIImageView alloc]initForAutoLayout];
    starLitarrowIV.image = [UIImage imageNamed:@"litarrow"];
    [self.view addSubview:starLitarrowIV];
    [self.view addConstraints:[starLitarrowIV constraintsTop:20 FromView:starLabel]];
    [self.view addConstraints:[starLitarrowIV constraintsRight:15 FromView:verticalLine]];
    
    UILabel * endLabel = [[UILabel alloc]initForAutoLayout];
    endLabel.font = ISSFont12;
    endLabel.textColor = ISSColorDardGray9;
    endLabel.text = @"结束";
    [self.view addSubview:endLabel];
    [self.view addConstraints:[endLabel constraintsTop:20 FromView:bottomLine]];
    [self.view addConstraints:[endLabel constraintsLeft:16 FromView:verticalLine]];
    
    endTimeDataLabel = [[UILabel alloc]initForAutoLayout];
    endTimeDataLabel.font = ISSFont12;
    endTimeDataLabel.textColor = ISSColorDardGray2;
    endTimeDataLabel.text = @"2017-11-15";
    [self.view addSubview:endTimeDataLabel];
    [self.view addConstraints:[endTimeDataLabel constraintsTop:20 FromView:endLabel]];
    [self.view addConstraints:[endTimeDataLabel constraintsLeft:16 FromView:verticalLine]];
    
    endTimeLabel = [[UILabel alloc]initForAutoLayout];
    endTimeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    endTimeLabel.textColor = ISSColorDardGray2;
    endTimeLabel.text = @"12:25:00";
    [self.view addSubview:endTimeLabel];
    [self.view addConstraints:[endTimeLabel constraintsTop:0 FromView:endTimeDataLabel]];
    [self.view addConstraints:[endTimeLabel constraintsLeft:16 FromView:verticalLine]];
    
    UIImageView * endLitarrowIV = [[UIImageView alloc]initForAutoLayout];
    endLitarrowIV.image = [UIImage imageNamed:@"litarrow"];
    [self.view addSubview:endLitarrowIV];
    [self.view addConstraints:[endLitarrowIV constraintsTop:20 FromView:starLabel]];
    [self.view addConstraints:[endLitarrowIV constraintsRightInContainer:15]];
    
    UIButton * starButton = [UIButton buttonWithType:UIButtonTypeCustom];
    starButton.translatesAutoresizingMaskIntoConstraints = NO;
    [starButton addTarget:self action:@selector(starButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:starButton];
    [self.view addConstraints:[starButton constraintsSize:CGSizeMake(kScreenWidth/2, 40)]];
    [self.view addConstraints:[starButton constraintsLeftInContainer:0]];
    [self.view addConstraints:[starButton constraintsTop:15 FromView:endLabel]];
    
    UIButton * endButton = [UIButton buttonWithType:UIButtonTypeCustom];
    endButton.translatesAutoresizingMaskIntoConstraints = NO;
    [endButton addTarget:self action:@selector(endButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endButton];
    [self.view addConstraints:[endButton constraintsSize:CGSizeMake(kScreenWidth/2, 40)]];
    [self.view addConstraints:[endButton constraintsRightInContainer:0]];
    [self.view addConstraints:[endButton constraintsTop:15 FromView:endLabel]];

    UIButton * cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraButton.translatesAutoresizingMaskIntoConstraints = NO;
    [cameraButton setImage:[UIImage imageNamed:@"bigscreenshot"]  forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(ssPhoto) forControlEvents:UIControlEventTouchUpInside];
    [_playerControlView addSubview:cameraButton];
    [cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.right.equalTo(_fullscreenButton);
        make.bottom.equalTo(_fullscreenButton.mas_top);
    }];
}

- (void)starButtonAction {
    __weak typeof(self) weakSelf = self;
    ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:@"开始时间"
                                                                  datePickerMode:UIDatePickerModeDateAndTime
                                                                    selectedDate:_startDate
                                                                       doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
                                                                           _startDate = selectedDate;
                                                                           [weakSelf showStartTime];
                                                                       } cancelBlock:nil
                                                                          origin:self.view];
    [picker showActionSheetPicker];
}

- (void)endButtonAction {
    __weak typeof(self) weakSelf = self;
    ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:@"结束时间"
                                                                  datePickerMode:UIDatePickerModeDateAndTime
                                                                    selectedDate:_endDate
                                                                       doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
                                                                           _endDate = selectedDate;
                                                                           [weakSelf showEndTime];
                                                                       } cancelBlock:nil
                                                                          origin:self.view];
    [picker showActionSheetPicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showStartTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"yyyy-MM-dd";
    starTimeDataLabel.text = [formatter stringFromDate:_startDate];
    
    formatter.dateFormat = @"HH:mm:ss";
    starTimeLabel.text = [formatter stringFromDate:_startDate];
}

- (void)showEndTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"yyyy-MM-dd";
    endTimeDataLabel.text = [formatter stringFromDate:_endDate];
    
    formatter.dateFormat = @"HH:mm:ss";
    endTimeLabel.text = [formatter stringFromDate:_endDate];
}

- (void)doReplay {
    [self getReplayInfo];
}

- (void)continueReplay {
    if (_replaySession) {
        _player.isPaused = NO;
        
        [self replayStarted];
    }
}

- (void)getReplayInfo {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *starttime = [formatter stringFromDate:_startDate];
    NSString *endtime = [formatter stringFromDate:_endDate];
    
    UVQueryCondition *condition = [[UVQueryCondition alloc] init];
    [condition setOffset:0];
    [condition setLimit:10];
    [condition setIsQuerySub:NO];
    
    UVQueryReplayParam *queryparam = [[UVQueryReplayParam alloc] init];
    [queryparam setBeginTime:starttime];
    [queryparam setEndTime:endtime];
    
    [queryparam setCameraCode:_listModel.deviceCoding];
    [queryparam setQueryCondition:condition];
    
    [[LoadingManager shareInstance] startLoading];
    
    __block NSArray *recordList = nil;
    [[ISSCameraManager shareInstance].request execRequest:^{
        recordList = [[ISSCameraManager shareInstance].service queryReplay:queryparam];
    } finish:^(UVError *error) {
        if (error != nil) {
            [[ISSCameraManager shareInstance] showMsg:error.message];
            [[LoadingManager shareInstance] stopLoading];
            return;
        }
        if (recordList.count == 0) {
            [[ISSCameraManager shareInstance] showMsg:@"当前时间段没有录像信息"];
            [[LoadingManager shareInstance] stopLoading];
            return;
        }
        UVRecordInfo *info = (UVRecordInfo*)recordList.firstObject;
        UVStreamInfo *streaminfo = [UVStreamInfo defaultStreamInfo];
        UVStartReplayParam *param = [[UVStartReplayParam alloc] init];
        [param setCameraCode:_listModel.deviceCoding];
        [param setStreamInfo:streaminfo];
        [param setRecordInfo:info];
        
        _recordInfo = info;
        
        __block NSString *playSession = nil;
        [[ISSCameraManager shareInstance].request execRequest:^{
            playSession = [[ISSCameraManager shareInstance].service startReplay:param];
            _replaySession = playSession;
        } finish:^(UVError *error) {
            if(error != nil) {
                [[ISSCameraManager shareInstance] showMsg:error.message];
                [[LoadingManager shareInstance] stopLoading];
                return;
            }
            [self startPlayWithSession:playSession];
            long time = [_utils intervalFromLastDate:info.beginTime toTheDate:info.endTime];
            _slider.value = 0;
            _slider.minimumValue = 0;
            _slider.maximumValue = time;
            [_slider addTarget:self action:@selector(dragReplay) forControlEvents:UIControlEventValueChanged];
            [self showReplaySlider:YES];
            [self sliderAutoRun];
        } ];
    } ];
}

- (void)dragReplay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:_recordInfo.beginTime];
    NSDate *dragDate = [NSDate dateWithTimeInterval:[_slider value] sinceDate:date];
    NSString *dragTime = [UVUtils stringFromTime:dragDate];
    [[ISSCameraManager shareInstance].request execRequest:^{
        [[ISSCameraManager shareInstance].service dragReplay:_replaySession playDatetime:dragTime];
    } finish:nil];
}

- (void)sliderAutoRun {
    _timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)timerAction {
    _slider.value += 5;
}

- (void)startPlayWithSession:(NSString*)session_
{
    [self stopPlay:^{
        [[LoadingManager shareInstance] stopLoading];
        NSLog(@"start play with session:%@",session_);
        [_player AVInitialize:_playerImageView];
        NSString *str = [NSString stringWithFormat:@"tcp://%@:%d",[ISSCameraManager shareInstance].service.info.server,[ISSCameraManager shareInstance].service.info.mediaPort];
        NSURL *url = [NSURL URLWithString:str];
        [_player AVStartPlay:url session:session_];
        
        [self replayStarted];
    }];
}

- (void)stopPlay:(void (^)())block_ {
    if (_player.isPlaying) {
        NSString *session = _player.playSession;
        void (^stopListener)(UVError*) = ^(UVError *error){
            [_player AVStopPlay];
            //等待播放器停止
            while (_player.playStatus != PLAY_STATUS_CLOSED) {
                NSLog(@"wait player stop");
                [[ISSCameraManager shareInstance] showMsg:@"正在停止当前播放"];
                [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
            }
            [[ISSCameraManager shareInstance] showMsg:@""];
            if(block_ != nil) {
                block_();
            }
        };
        NSLog(@"replay playing,stop with session:%@",session);
        [[ISSCameraManager shareInstance].request execRequest:^{
            [[ISSCameraManager shareInstance].service stopReplay:session];
        } finish:stopListener];
        
    } else {
        if (block_ != nil) {
            block_();
        }
    }
}

#pragma mark 暂停播放

- (void)pauseReplay {
    if (!_player.isPlaying) {
        return;
    }
    
    _player.isPaused = YES;
    
    [self replayStopped];
}

- (void)showReplaySlider:(BOOL)show_ {
//    if (show_) {
//        _slider.userInteractionEnabled = NO;
//    } else {
//        _slider.userInteractionEnabled = YES;
//    }
}

- (void)replayStarted {
    _playerImageView.image = nil;
    _playerControlView.hidden = NO;
    _playButton1.hidden = YES;
    _playButton2.enabled = NO;
    _playButton2.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    _pauseButton.tag = 1;
    [_pauseButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
}

- (void)replayStopped {
    _playButton2.enabled = YES;
    _playButton2.layer.borderColor = [ISSColorNavigationBar CGColor];
    
    _pauseButton.tag = 0;
    [_pauseButton setImage:[UIImage imageNamed:@"litplay"] forState:UIControlStateNormal];
}

- (void)pauseClicked {
    if (_pauseButton.tag == 0) {
        [self continueReplay];
    } else {
        [self pauseReplay];
    }
}

- (void)fullClicked {
    if (_fullscreenButton.tag == 0) {
        [self toFullscreen];
        
        [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    } else {
        [self exitFullscreen];
        
        [self interfaceOrientation:UIInterfaceOrientationPortrait];
    }
}

- (void)toFullscreen {
    _fullscreenButton.tag = 1;
    [_fullscreenButton setImage:[UIImage imageNamed:@"fullscreen-exit"] forState:UIControlStateNormal];
}

- (void)exitFullscreen {
    _fullscreenButton.tag = 0;
    [_fullscreenButton setImage:[UIImage imageNamed:@"fullscreen"] forState:UIControlStateNormal];
}

#pragma mark 全屏

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)deviceOrientationDidChange
{
    NSLog(@"NAV deviceOrientationDidChange:%ld",(long)[UIDevice currentDevice].orientation);
    if([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        [self orientationChange:NO];
        //注意： UIDeviceOrientationLandscapeLeft 与 UIInterfaceOrientationLandscapeRight
    } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        [self orientationChange:YES];
    }
}

- (void)orientationChange:(BOOL)landscapeRight
{
    [self setNeedsStatusBarAppearanceUpdate];
    
    float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    BOOL isIOS10 = NO;
    if (osVersion >= 10.0 && osVersion < 11.0) {
        isIOS10 = YES;
    }
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    if (landscapeRight) {
        [[UIApplication sharedApplication].keyWindow addSubview:_playerView];
        
        [UIView animateWithDuration:0.2f animations:^{
            _playerView.transform = CGAffineTransformMakeRotation(M_PI_2);
            _playerView.frame = CGRectMake(0, 0, width, height);
            
            if (isIOS10) {
                _playerImageView.frame = CGRectMake(0, 0, CGRectGetHeight(_playerView.frame), CGRectGetWidth(_playerView.frame));
            } else {
                _playerImageView.frame = _playerView.bounds;
            }
            _playerControlView.frame = _playerImageView.bounds;
        }];
    } else {
        [self.view addSubview:_playerView];
        
        [UIView animateWithDuration:0.2f animations:^{
            _playerView.transform = CGAffineTransformMakeRotation(0);
            _playerView.frame = CGRectMake(0, 0, width, width * (9.0 / 16.0));
            
            _playerImageView.frame = _playerView.bounds;
            _playerControlView.frame = _playerImageView.bounds;
        }];
    }
}

- (BOOL)prefersStatusBarHidden {
    return _fullscreenButton.tag == 1;
}

- (void)ssPhoto {
    [ISSVideoPhotoManager createPhoto:_player code:_listModel.deviceCoding];
}

- (void)onSnatchStatus:(UVPlayer*)sender_ path:(NSURL*)path_ error:(UVError*)error_ {
    if (error_) {
        [self.view makeToast:error_.message];
    } else {
        [_playerImageView makeToast:@"抓拍成功"];
    }
}

@end
