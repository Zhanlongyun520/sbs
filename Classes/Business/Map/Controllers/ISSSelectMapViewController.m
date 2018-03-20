//
//  ISSSelectMapViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/29.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSSelectMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "ISSSelectAnnotationView.h"

#import "ISSRealTimeViewController.h"
#import "ISSHistoryViewController.h"

#import "ISSMapCameraPopupView.h"
#import "ISSVideoPhotoViewController.h"
#import "ISSVideoPhotoManager.h"
#import "Masonry.h"

@interface ISSSelectMapViewController ()<MAMapViewDelegate>
{
    ISSMapCameraPopupView *_cameraPopupView;
}

@property (nonatomic, strong) MAMapView                         * mapView;
@property (nonatomic, strong) ISSSelectAnnotationView           * selectAnnotationView;


@end

@implementation ISSSelectMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenTabBar = YES;
    
    [self.view addSubview:self.mapView];
    [self.mapView addSubview:self.selectAnnotationView];

    [self addAnnotation];
}

#pragma mark - Button Action
- (void)cancelButtonAction
{
    self.selectAnnotationView.hidden = YES;
}

- (void)realTimeButtonAction
{
    ISSRealTimeViewController * realtimeVC = [[ISSRealTimeViewController alloc]init];
//    realtimeVC.listModel = _videoModel;
    [self.navigationController pushViewController:realtimeVC animated:YES];
}

- (void)historyButtonAction
{
    ISSHistoryViewController * historyVC = [[ISSHistoryViewController alloc]init];
//    historyVC.listModel = _videoModel;
    [self.navigationController pushViewController:historyVC animated:YES];
}



#pragma mark - Map Delegate

- (void)addAnnotation
{
    ISSVideoModel * model = self.videoModel;
    CLLocationCoordinate2D coor ;
    coor.latitude = [model.latitude doubleValue];
    coor.longitude = [model.longitude doubleValue];
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//    pointAnnotation.fr
    pointAnnotation.title = @"";
    pointAnnotation.coordinate = coor;
    self.mapView.centerCoordinate = coor;
    [self.mapView addAnnotation:pointAnnotation];
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    [self showCameraDeviceView:_videoModel];
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    //大头针
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
//            annotationView.size = CGSizeMake(20, 20);
        }
        annotationView.animatesDrop = YES;
        
        ISSVideoModel * model =  self.videoModel;
        if ([model.deviceType intValue] == 0) {
            [self videoAnnotation:annotationView StateString:model.deviceStatus];
        }else{
            if ([model.deviceStatus isEqualToString:@"0"]) {
                [self environmentAnnotation:annotationView PM10:[model.eqiModel.pm10 intValue]];
            }else{
                annotationView.image = [UIImage imageNamed:@"environment-gray"];
            }
        }
        return annotationView;
    }
    
    return nil;
}

#pragma mark - Judge Logic
- (void)environmentAnnotation:(MAPinAnnotationView *)annotationView PM10:(int )pm10Int
{
    if (pm10Int < 1) {
        annotationView.image = [UIImage imageNamed:@"environment-blue"];
    }else if (pm10Int < 51){
        annotationView.image = [UIImage imageNamed:@"environment-green"];
    }else if (pm10Int < 151){
        annotationView.image = [UIImage imageNamed:@"environment-yellow"];
    }else if (pm10Int < 251){
        annotationView.image = [UIImage imageNamed:@"environment-orange"];
    }else if (pm10Int < 351){
        annotationView.image = [UIImage imageNamed:@"environment-red"];
    }else if (pm10Int < 421){
        annotationView.image = [UIImage imageNamed:@"environment-pink"];
    }else{
        annotationView.image = [UIImage imageNamed:@"environment-dark"];
    }
    
}


- (void)videoAnnotation:(MAPinAnnotationView *)annotationView StateString:(NSString *)stateString
{
    if ([stateString isEqualToString:@"0"]) {
        annotationView.image = [UIImage imageNamed:@"camera-normal"];
    }else if ([stateString isEqualToString:@"1"]){
        annotationView.image = [UIImage imageNamed:@"camera-gray"];
    }else if ([stateString isEqualToString:@"2"]){
        annotationView.image = [UIImage imageNamed:@"camera-red"];
    }
}

#pragma mark - Setter && Getter

- (MAMapView *)mapView
{
    if(_mapView == nil)
    {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _mapView.delegate = self;
        _mapView.zoomLevel = 13;
        _mapView.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _mapView;
}

- (ISSSelectAnnotationView *)selectAnnotationView
{
    if(_selectAnnotationView == nil){
        _selectAnnotationView = [[ISSSelectAnnotationView alloc]initWithFrame:CGRectMake(0, kScreenHeight - kNavBarAndStatBarHeight - 200 - 16, kScreenWidth, 200)];
        [_selectAnnotationView.cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_selectAnnotationView.realTimeButton addTarget:self action:@selector(realTimeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_selectAnnotationView.historyButton addTarget:self action:@selector(historyButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _selectAnnotationView.hidden = YES;
    }
    return _selectAnnotationView;
}

#pragma mark 点击摄像头

- (void)showCameraDeviceView:(ISSVideoModel *)model {
    if (_cameraPopupView) {
        [_cameraPopupView removeFromSuperview];
        _cameraPopupView = nil;
    }
    __weak typeof(self) weakSelf = self;
    _cameraPopupView = [[ISSMapCameraPopupView alloc] init:NO];
    _cameraPopupView.dissmissBlock = ^{
        [weakSelf dissmissCameraPopupView];
    };
    _cameraPopupView.showDetailBlock = ^(ISSVideoModel *model, NSInteger index) {
        [weakSelf showCameraDetail:model tag:index];
    };
    [self.view addSubview:_cameraPopupView];
    [_cameraPopupView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(self.view);
        make.top.equalTo(@(CGRectGetHeight(self.view.frame)));
    }];
    _cameraPopupView.model = model;
    
    [self performSelector:@selector(animatedShowCameraPopupView) withObject:nil afterDelay:CGFLOAT_MIN];
}

- (void)animatedShowCameraPopupView {
    [_cameraPopupView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
    }];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}

- (void)dissmissCameraPopupView {
    [_cameraPopupView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(CGRectGetHeight(self.view.frame)));
    }];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         [_cameraPopupView removeFromSuperview];
                         _cameraPopupView = nil;
                     }];
}

- (void)showCameraDetail:(ISSVideoModel *)model tag:(NSInteger)tag {
    switch (tag) {
        case 1: {
            ISSRealTimeViewController * realTimeVC = [[ISSRealTimeViewController alloc]init];
            realTimeVC.listModel = model;
            [self.navigationController pushViewController:realTimeVC animated:YES];
            
            break;
        }
            
        case 2: {
            ISSHistoryViewController * historyVC = [[ISSHistoryViewController alloc]init];
            historyVC.listModel = model;
            [self.navigationController pushViewController:historyVC animated:YES];
            
            break;
        }
            
        case 3: {
            NSArray *array = [ISSVideoPhotoManager getPhotos:model.deviceCoding];
            if (array.count == 0) {
                [self.navigationController.view makeToast:@"此设备没有视频抓拍记录"];
                return;
            }
            
            ISSVideoPhotoViewController *viewController = [[ISSVideoPhotoViewController alloc] init];
            viewController.code = model.deviceCoding;
            [self.navigationController pushViewController:viewController animated:YES];
            
            break;
        }
            
        default:
            break;
    }
}

@end
