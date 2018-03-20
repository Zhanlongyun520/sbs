//
//  ISSRealTimeViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSRealTimeViewController.h"
#import "AppDelegate.h"
#import "ISSVideoPhotoManager.h"
#import "UVPlayerDelegate.h"
#import "UVPtzCommandParam.h"
#import "MMAlertView.h"
#import "ISSCameraManager.h"
#import "Masonry.h"

/**
 * @enum  tagMwPtzCmdEnum
 * @brief 云台控制命令枚举
 * @attention
 */
typedef enum tagMwPtzCmdEnum
{
    MW_PTZ_ZOOMTELESTOP      = 0x0301,/**< 放大停止 */
    MW_PTZ_ZOOMTELE          = 0x0302,/**< 放大 */
    MW_PTZ_ZOOMWIDESTOP      = 0x0303,/**< 缩小停止 */
    MW_PTZ_ZOOMWIDE          = 0x0304,/**< 缩小 */
    
    MW_PTZ_TILTUPSTOP        = 0x0401,/**< 向上停止 */
    MW_PTZ_TILTUP            = 0x0402,/**< 向上 */
    MW_PTZ_TILTDOWNSTOP      = 0x0403,/**< 向下停止 */
    MW_PTZ_TILTDOWN          = 0x0404,/**< 向下 */
    
    MW_PTZ_PANRIGHTSTOP      = 0x0501,/**< 向右停止 */
    MW_PTZ_PANRIGHT          = 0x0502,/**< 向右 */
    MW_PTZ_PANLEFTSTOP       = 0x0503,/**< 向左停止 */
    MW_PTZ_PANLEFT           = 0x0504,/**< 向左 */
    
    MW_PTZ_LEFTUPSTOP        = 0x0701,/**< 左上停止 */
    MW_PTZ_LEFTUP            = 0x0702,/**< 左上 */
    MW_PTZ_LEFTDOWNSTOP      = 0x0703,/**< 左下停止 */
    MW_PTZ_LEFTDOWN          = 0x0704,/**< 左下 */
    
    MW_PTZ_RIGHTUPSTOP       = 0x0801,/**< 右上停止 */
    MW_PTZ_RIGHTUP           = 0x0802,/**< 右上 */
    MW_PTZ_RIGHTDOWNSTOP     = 0x0803,/**< 右下停止 */
    MW_PTZ_RIGHTDOWN         = 0x0804,/**< 右下 */
    
    MW_PTZ_ALLSTOP           = 0x0901,/**< 全停命令字 */
    
    MW_PTZ_UPTELESTOP        = 0x0411,/**< 向上放大停止 */
    MW_PTZ_UPTELE            = 0x0412,/**< 向上放大 */
    MW_PTZ_DOWNTELESTOP      = 0x0413,/**< 向下放大停止 */
    MW_PTZ_DOWNTELE          = 0x0414,/**< 向下放大 */
    
    MW_PTZ_UPWIDESTOP        = 0x0421,/**< 向上缩小停止 */
    MW_PTZ_UPWIDE            = 0x0422,/**< 向上缩小 */
    MW_PTZ_DOWNWIDESTOP      = 0x0423,/**< 向下缩小停止 */
    MW_PTZ_DOWNWIDE          = 0x0424,/**< 向下缩小 */
    
    MW_PTZ_RIGHTTELESTOP     = 0x0511,/**< 向右放大停止 */
    MW_PTZ_RIGHTTELE         = 0x0512,/**< 向右放大 */
    MW_PTZ_LEFTTELESTOP      = 0x0513,/**< 向左放大停止 */
    MW_PTZ_LEFTTELE          = 0x0514,/**< 向左放大 */
    
    MW_PTZ_RIGHTWIDESTOP     = 0x0521,/**< 向右缩小停止 */
    MW_PTZ_RIGHTWIDE         = 0x0522,/**< 向右缩小 */
    MW_PTZ_LEFTWIDESTOP      = 0x0523,/**< 向左缩小停止 */
    MW_PTZ_LEFTWIDE          = 0x0524,/**< 向左缩小 */
    
    MW_PTZ_LEFTUPTELESTOP    = 0x0711,/**< 左上放大停止 */
    MW_PTZ_LEFTUPTELE        = 0x0712,/**< 左上放大 */
    MW_PTZ_LEFTDOWNTELESTOP  = 0x0713,/**< 左下放大停止 */
    MW_PTZ_LEFTDOWNTELE      = 0x0714,/**< 左下放大 */
    
    MW_PTZ_LEFTUPWIDESTOP    = 0x0721,/**< 左上缩小停止 */
    MW_PTZ_LEFTUPWIDE        = 0x0722,/**< 左上缩小 */
    MW_PTZ_LEFTDOWNWIDESTOP  = 0x0723,/**< 左下缩小停止 */
    MW_PTZ_LEFTDOWNWIDE      = 0x0724,/**< 左下缩小 */
    
    MW_PTZ_RIGHTUPTELESTOP   = 0x0811,/**< 右上放大停止 */
    MW_PTZ_RIGHTUPTELE       = 0x0812,/**< 右上放大 */
    MW_PTZ_RIGHTDOWNTELESTOP = 0x0813,/**< 右下放大停止 */
    MW_PTZ_RIGHTDOWNTELE     = 0x0814,/**< 右下放大 */
    
    MW_PTZ_RIGHTUPWIDESTOP   = 0x0821,/**< 右上缩小停止 */
    MW_PTZ_RIGHTUPWIDE       = 0x0822,/**< 右上缩小 */
    MW_PTZ_RIGHTDOWNWIDESTOP = 0x0823,/**< 右下缩小停止 */
    MW_PTZ_RIGHTDOWNWIDE     = 0x0824,/**< 右下缩小 */
    
    MW_PTZ_CMD_BUTT
}MW_PTZ_CMD_E;

@interface ISSRealTimeViewController () <UVPlayerDelegate>
{
    UIImageView *_imageviewPreview;
    
    UVStreamPlayer *_streamplayer;
    
    BOOL _fullScreen;
    
    BOOL _isStartPtz;
    
    NSInteger _typeIndex;
    NSArray *_typeArray;
    
    UIButton *_typeButton;
}
@end

@implementation ISSRealTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ISSColorBlack;
    
    self.isHiddenTabBar = YES;
    self.ishiddenNav = YES;
    
    [self setUI];
    
    self.navigationController.navigationBarHidden = YES;
    
    _fullScreen = NO;
    
    _typeIndex = 0;
    _typeArray = @[@{@"text": @"流畅", @"value": @(UV_STREAM_RESOLUTION_D1)},
                   @{@"text": @"清晰", @"value": @(UV_STREAM_RESOLUTION_CIF)},
                   @{@"text": @"高清", @"value": @(UV_STREAM_RESOLUTION_720P)}];

    [self startPlay];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!_fullScreen) {
        _fullScreen = YES;
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
        
        [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [super viewWillDisappear:animated];
}

- (void)popNav {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUI {
    _imageviewPreview = [[UIImageView alloc] init];
    [self.view addSubview:_imageviewPreview];
    [_imageviewPreview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UILabel *navView = [[UILabel alloc] init];
    navView.userInteractionEnabled = YES;
    navView.textColor = [UIColor whiteColor];
    navView.textAlignment = NSTextAlignmentCenter;
    navView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    navView.text = @"实时视频";
    [self.view addSubview:navView];
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.tintColor = [UIColor whiteColor];
    [backButton setImage:[UIImage imageNamed:@"bigarrow"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popNav) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(navView);
        make.width.equalTo(@44);
    }];
    
    UIButton * bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomButton.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomButton setImage:[UIImage imageNamed:@"videodown"]  forState:UIControlStateNormal];
    [self.view addSubview:bottomButton];
    [self.view addConstraints:[bottomButton constraintsBottomInContainer:20]];
    [self.view addConstraints:[bottomButton constraintsLeftInContainer:60]];
    [bottomButton addTarget:self action:@selector(controlCamera:) forControlEvents:UIControlEventTouchUpInside];
    bottomButton.tag = 3;
    
    UIButton * pointButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pointButton.translatesAutoresizingMaskIntoConstraints = NO;
    [pointButton setImage:[UIImage imageNamed:@"videopoint"]  forState:UIControlStateNormal];
    [self.view addSubview:pointButton];
    [self.view addConstraints:[pointButton constraintsBottom:15 FromView:bottomButton]];
    [self.view addConstraints:[pointButton constraintsLeftInContainer:67]];
    
    UIButton * topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    topButton.translatesAutoresizingMaskIntoConstraints = NO;
    [topButton setImage:[UIImage imageNamed:@"videoup"]  forState:UIControlStateNormal];
    [self.view addSubview:topButton];
    [self.view addConstraints:[topButton constraintsBottom:15 FromView:pointButton]];
    [self.view addConstraints:[topButton constraintsLeftInContainer:60]];
    [topButton addTarget:self action:@selector(controlCamera:) forControlEvents:UIControlEventTouchUpInside];
    topButton.tag = 1;

    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    [leftButton setImage:[UIImage imageNamed:@"videoleft"]  forState:UIControlStateNormal];
    [self.view addSubview:leftButton];
    [self.view addConstraints:[leftButton constraintsBottom:10 FromView:bottomButton]];
    [self.view addConstraints:[leftButton constraintsRight:15 FromView:pointButton]];
    [leftButton addTarget:self action:@selector(controlCamera:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.tag = 4;
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [rightButton setImage:[UIImage imageNamed:@"videoright"]  forState:UIControlStateNormal];
    [self.view addSubview:rightButton];
    [self.view addConstraints:[rightButton constraintsBottom:10 FromView:bottomButton]];
    [self.view addConstraints:[rightButton constraintsLeft:15 FromView:pointButton]];
    [rightButton addTarget:self action:@selector(controlCamera:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.tag = 2;
    
    UIButton * cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraButton.translatesAutoresizingMaskIntoConstraints = NO;
    [cameraButton setImage:[UIImage imageNamed:@"bigscreenshot"]  forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(ssPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraButton];
    [self.view addConstraints:[cameraButton constraintsBottomInContainer:30]];
    [self.view addConstraints:[cameraButton constraintsRightInContainer:25]];
    
    _typeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _typeButton.tintColor = [UIColor whiteColor];
    _typeButton.tag = 5;
    [_typeButton addTarget:self action:@selector(controlCamera:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_typeButton];
    [_typeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.right.equalTo(cameraButton);
        make.bottom.equalTo(cameraButton.mas_top).offset(-15);
    }];
    
    UIButton *smallButton = [UIButton buttonWithType:UIButtonTypeSystem];
    smallButton.tintColor = [UIColor whiteColor];
    smallButton.tag = 6;
    smallButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [smallButton setTitle:@"-" forState:UIControlStateNormal];
    [smallButton addTarget:self action:@selector(controlCamera:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:smallButton];
    [smallButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.right.equalTo(_typeButton);
        make.bottom.equalTo(_typeButton.mas_top).offset(-15);
    }];
    
    UIButton *bigButton = [UIButton buttonWithType:UIButtonTypeSystem];
    bigButton.tintColor = [UIColor whiteColor];
    bigButton.tag = 7;
    bigButton.titleLabel.font = smallButton.titleLabel.font;
    [bigButton setTitle:@"+" forState:UIControlStateNormal];
    [bigButton addTarget:self action:@selector(controlCamera:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bigButton];
    [bigButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.right.equalTo(smallButton);
        make.bottom.equalTo(smallButton.mas_top).offset(-15);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startPlay {
    if (_streamplayer.isPlaying) {
        [_streamplayer AVStopPlay];
    }
    
    
    int32_t res = UV_STREAM_RESOLUTION_720P;
    if (_typeIndex < _typeArray.count) {
        NSDictionary *dic = [_typeArray objectAtIndex:_typeIndex];
        res = [[dic objectForKey:@"value"] intValue];
    }
    
    UVStartLiveParam *param = [[UVStartLiveParam alloc] init];
    UVStreamInfo *streaminfo = [UVStreamInfo defaultStreamInfo];
    streaminfo.resolution = res;
    [param setCameraCode:_listModel.deviceCoding];
    [param setUseSecondStream:YES];
    [param setStreamInfo:streaminfo];
    __block NSString *playSession = nil;
    
    [[ISSCameraManager shareInstance].request execRequest:^{
        playSession = [[ISSCameraManager shareInstance].service startLive:param withTimeOut:5.0];
    } finish:^(UVError *error) {
        if(error != nil) {
            [[ISSCameraManager shareInstance] showError:error];
            return;
        }
        _streamplayer = [[UVStreamPlayer alloc] initWithDelegate:self];
        [_streamplayer AVInitialize:_imageviewPreview];
        NSString *str = [NSString stringWithFormat:@"tcp://%@:%d",[ISSCameraManager shareInstance].service.info.server,[ISSCameraManager shareInstance].service.info.mediaPort];
        NSURL  *url = [NSURL URLWithString:str];
        [_streamplayer AVStartPlay:url session:playSession];
        
        [self showTypeText];
    } showProgressInView:self.view];
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
//        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
//        [self orientationChange:NO];
    } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        [self orientationChange:YES];
    }
}

- (void)orientationChange:(BOOL)landscapeRight
{
    [self setNeedsStatusBarAppearanceUpdate];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (landscapeRight) {
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.view.frame = CGRectMake(0, 0, width, height);
        }];
    } else {
//        [UIView animateWithDuration:0.2f animations:^{
//            self.view.transform = CGAffineTransformMakeRotation(0);
//            self.view.frame = CGRectMake(0, 0, width, height);
//        }];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)ssPhoto {
    [ISSVideoPhotoManager createPhoto:_streamplayer code:_listModel.deviceCoding];
}

- (void)onSnatchStatus:(UVPlayer*)sender_ path:(NSURL*)path_ error:(UVError*)error_ {
    if (error_) {
        [self.view makeToast:error_.message];
    } else {
        [_imageviewPreview makeToast:@"抓拍成功"];
    }
}

#pragma mark 控制

- (void)controlCamera:(UIButton *)button {
    if (button.tag == 5) {
        [self showTypes];
        
        return;
    }
    
    if (_isStartPtz) {
        [self controlCameraMethod:button];
    } else {
        [[ISSCameraManager shareInstance].request execRequest:^{
            [[ISSCameraManager shareInstance].service startCameraPtz:_listModel.deviceCoding];
        } finish:^(UVError *error) {
            if (error) {
                [[ISSCameraManager shareInstance] showMsg:error.message];
                NSLog(@"error:%@", error.message);
                return;
            }
            _isStartPtz = YES;
            
            [self controlCameraMethod:button];
        }];
    }
}

- (void)controlCameraMethod:(UIButton *)button {
    MW_PTZ_CMD_E dir;
    switch (button.tag) {
        case 1:
            dir = MW_PTZ_TILTUP;
            break;
            
        case 2:
            dir = MW_PTZ_PANRIGHT;
            break;
            
        case 3:
            dir = MW_PTZ_TILTDOWN;
            break;
            
        case 4:
            dir = MW_PTZ_PANLEFT;
            break;
            
        case 6:
            dir = MW_PTZ_ZOOMWIDE;
            break;
            
        case 7:
            dir = MW_PTZ_ZOOMTELE;
            break;
            
        default:
            dir = MW_PTZ_TILTUP;
            break;
    }
    [self startControl:dir tag:button.tag isStart:YES];
}

- (void)startControl:(MW_PTZ_CMD_E)dir tag:(NSInteger)tag isStart:(BOOL)isStart {
    self.view.userInteractionEnabled = NO;
    
    UVPtzCommandParam *param = [[UVPtzCommandParam alloc] init];
    param.cameraCode = _listModel.deviceCoding;
    param.direction = dir;
    param.speed1 = 5.0f;
    param.speed2 = 5.0f;
    
    [[ISSCameraManager shareInstance].request execRequest:^{
        [[ISSCameraManager shareInstance].service cameraPtzCommand:param];
    } finish:^(UVError *error) {
        if (isStart) {
            [self stopControl:tag];
        } else {
            self.view.userInteractionEnabled = YES;
        }
        if (error) {
            [[ISSCameraManager shareInstance] showMsg:error.message];
            NSLog(@"error:%@", error.message);
            return;
        }
    }];
}

- (void)stopControl:(NSInteger)tag {
    MW_PTZ_CMD_E dir;
    switch (tag) {
        case 1:
            dir = MW_PTZ_TILTUPSTOP;
            break;
            
        case 2:
            dir = MW_PTZ_PANRIGHTSTOP;
            break;
            
        case 3:
            dir = MW_PTZ_TILTDOWNSTOP;
            break;
            
        case 4:
            dir = MW_PTZ_PANLEFTSTOP;
            break;
            
        case 6:
            dir = MW_PTZ_ZOOMWIDESTOP;
            break;
            
        case 7:
            dir = MW_PTZ_ZOOMTELESTOP;
            break;
            
        default:
            dir = MW_PTZ_TILTUPSTOP;
            break;
    }
    [self startControl:dir tag:tag isStart:NO];
}

- (void)showTypes {
    __weak typeof(self) weakSelf = self;
    
    MMPopupItemHandler block = ^(NSInteger index){
        [weakSelf typeClicked:index];
    };
    
    NSMutableArray *items = @[].mutableCopy;
    [_typeArray enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
        [items addObject:MMItemMake([dic objectForKey:@"text"], _typeIndex == idx ? MMItemTypeHighlight : MMItemTypeNormal, block)];
    }];
    [items addObject:MMItemMake(@"取消", MMItemTypeNormal, block)];
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"选择清晰度"
                                                         detail:nil
                                                          items:items];
    alertView.attachedView = self.view;
    alertView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleLight;
    [alertView show];
}

- (void)typeClicked:(NSInteger)index {
    if (index >= _typeArray.count) {
        return;
    }
    
    if (_typeIndex == index) {
        return;
    }
    
    _typeIndex = index;
    
    [self startPlay];
}

- (void)showTypeText {
    if (_typeIndex < _typeArray.count) {
        NSDictionary *dic = [_typeArray objectAtIndex:_typeIndex];
        
        [_typeButton setTitle:[dic objectForKey:@"text"] forState:UIControlStateNormal];
    }
}

@end
