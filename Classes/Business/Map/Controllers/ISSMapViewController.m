//
//  ISSMapViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "APIVideoListManager.h"
#import "ISSVideoListReformer.h"
#import "ISSVideoModel.h"
#import "ISSSelectAnnotationView.h"

#import "ISSRealTimeViewController.h"
#import "ISSHistoryViewController.h"
#import "ISSMapCameraPopupView.h"
#import "ISSVideoPhotoManager.h"
#import "ISSVideoPhotoViewController.h"
#import "ISSMapPMPopupView.h"
#import "NetworkRequest.h"
#import "ISSMapEqiModel.h"
#import "ISSEnvironmentRealTimeViewController.h"
#import "ISSEnvironmentHistoryViewController.h"
#import "ISSEnvironmentListModel.h"
#import "ISSMapPinAnnotationView.h"
#import "ISSMapPointAnnotation.h"

@interface ISSMapViewController ()<MAMapViewDelegate,APIManagerCallBackDelegate>
{
    ISSMapCameraPopupView *_cameraPopupView;
    ISSMapPMPopupView *_pMPopupView;
    
    NSMutableArray *_positionAnnotaionList;
    
    NSArray *_eqiList;
}

@property (nonatomic, strong) UIImageView                 * bottomIV;
@property (nonatomic, strong) APIVideoListManager         * videoListManager;
@property (nonatomic, strong) NSArray                     * videoListArray;



@end

@implementation ISSMapViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"地图";
    if (self.selectedDeviceId) {
        self.isHiddenTabBar = YES;
    } else {
        [self hiddenBackBarButtonItem];
    }
    
    _positionAnnotaionList = @[].mutableCopy;
    
    _bottomIV = [[UIImageView alloc]init];
    _bottomIV.image = [UIImage imageNamed:@"pollutecard"];
    [self.view addSubview:_bottomIV];
    [_bottomIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.selectedDeviceId ? @0 : @-49);
        make.height.equalTo(@40);
    }];
    
    [_mapView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.equalTo(_bottomIV.mas_top);
    }];

    [self getEqiList];
    
    [kDefaultCenter addObserver:self selector:@selector(viewRefresh) name:kMapVCRefresh object:nil];
}

- (void)viewRefresh
{
    [self getEqiList];
}

- (void)addAnimatedVideoArray:(NSArray *)videoArray
{
    [_mapView removeAnnotations:_positionAnnotaionList];
    [_positionAnnotaionList removeAllObjects];
    
    for(int i=0 ; i< videoArray.count ;i++) {
        ISSVideoModel * model = videoArray[i];
        CLLocationCoordinate2D coor ;
        coor.latitude = [model.latitude doubleValue];
        coor.longitude = [model.longitude doubleValue];
        ISSMapPointAnnotation *pointAnnotation = [[ISSMapPointAnnotation alloc] init];
        pointAnnotation.title = @"";
        pointAnnotation.coordinate = coor;
        pointAnnotation.subtitle = [NSString stringWithFormat:@"%d",i];
        pointAnnotation.model = model;
//        _mapView.centerCoordinate = coor;
        if (self.showType == 1) {
            if ([model.deviceType integerValue] == 1) {
                if (self.showSinger) {
                    if ([self.selectedDeviceId isEqualToString:model.deviceId]) {
                        [_positionAnnotaionList addObject:pointAnnotation];
                    }
                }
                else {
                    [_positionAnnotaionList addObject:pointAnnotation];
                }
            }
        }
        else if (self.showType == 2) {
            if ([model.deviceType integerValue] != 1) {
                if (self.showSinger) {
                    if ([self.selectedDeviceId isEqualToString:model.deviceId]) {
                        [_positionAnnotaionList addObject:pointAnnotation];
                    }
                }
                else {
                    [_positionAnnotaionList addObject:pointAnnotation];
                }
            }
        }
        else {
            [_positionAnnotaionList addObject:pointAnnotation];
        }
        
        dispatch_after(0.01, dispatch_get_main_queue(), ^{
            if (self.selectedDeviceId && self.selectedDeviceId.length > 0) {
                if ([model.deviceId isEqualToString:self.selectedDeviceId]) {
                    [self selectAnntaion:pointAnnotation];
                }
            }
        });
    }
    [_mapView addAnnotations:_positionAnnotaionList];
}


#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    NSDictionary * dic = [manager fetchDataWithReformer:[[ISSVideoListReformer alloc]init]];
    self.videoListArray = dic[@"videoArray"];
    
    for (ISSVideoModel *model in self.videoListArray) {
        for (ISSMapEqiModel *obj in _eqiList) {
            if ([model.deviceId isEqualToString:obj.deviceId]) {
                model.eqiModel = obj;
                break;
            }
        }
    }
    
    [self addAnimatedVideoArray:self.videoListArray];
    NSLog(@"%@",dic);
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{

}

- (void)selectAnntaion:(ISSMapPointAnnotation *)annotation {
    annotation.selected = YES;
    [_mapView removeAnnotation:annotation];
    [_mapView addAnnotation:annotation];
    
    ISSVideoModel *model = annotation.model;
    if ([model.deviceType intValue] == 1) { // 监控
        [self showCameraDeviceView:model];
    } else { // PM10
        [self showPMDeviceView:model];
    }
}

#pragma mark - Map Delegte

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    if ([view isKindOfClass:[ISSMapPinAnnotationView class]]) {
        for (ISSMapPointAnnotation *an in _positionAnnotaionList) {
            an.selected = NO;
        }
        ISSMapPointAnnotation *annotation = (ISSMapPointAnnotation *)view.annotation;
        [self selectAnntaion:annotation];
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    //大头针
    if ([annotation isKindOfClass:[ISSMapPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        ISSMapPinAnnotationView *annotationView = (ISSMapPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[ISSMapPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }

        ISSMapPointAnnotation *theAnnotation = (ISSMapPointAnnotation *)annotation;
        ISSVideoModel *model = (ISSVideoModel *)theAnnotation.model;
        
        annotationView.selectedImageView.hidden = !theAnnotation.selected;
        
        if ([model.deviceType intValue] == 1) { // 监控
            [self videoAnnotation:annotationView StateString:model.deviceStatus];
        }else{ // PM10
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
- (void)environmentAnnotation:(ISSMapPinAnnotationView *)annotationView PM10:(int )pm10Int
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


- (void)videoAnnotation:(ISSMapPinAnnotationView *)annotationView StateString:(NSString *)stateString
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

- (APIVideoListManager *)videoListManager
{
    if (nil == _videoListManager) {
        _videoListManager = [[APIVideoListManager alloc] init];
        _videoListManager.delegate = self;
        _videoListManager.page = @"0";
        _videoListManager.size = @"100";
//        _videoListManager.deviceType = @"1"; //视屏设备
    }
    return _videoListManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 点击摄像头

- (void)showCameraDeviceView:(ISSVideoModel *)model {
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake([model.latitude doubleValue], [model.longitude doubleValue]) animated:YES];
    
    if (_cameraPopupView) {
        [_cameraPopupView removeFromSuperview];
        _cameraPopupView = nil;
    }
    __weak typeof(self) weakSelf = self;
    _cameraPopupView = [[ISSMapCameraPopupView alloc] init:!_selectedDeviceId];
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
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         [_cameraPopupView removeFromSuperview];
                         _cameraPopupView = nil;
                         [weakSelf deselectAnnotation];
                     }];
}

- (void)showCameraDetail:(ISSVideoModel *)model tag:(NSInteger)tag {
    switch (tag) {
        case 1: {
            ISSRealTimeViewController * realTimeVC = [[ISSRealTimeViewController alloc]init];
            realTimeVC.listModel = model;
            realTimeVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:realTimeVC animated:YES];
            
            break;
        }
            
        case 2: {
            ISSHistoryViewController * historyVC = [[ISSHistoryViewController alloc]init];
            historyVC.listModel = model;
            historyVC.hidesBottomBarWhenPushed = YES;
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
            viewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:viewController animated:YES];
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark 点击PM

- (void)deselectAnnotation {
    for (ISSMapPointAnnotation *an in _positionAnnotaionList) {
        an.selected = NO;
    }
    [_mapView removeAnnotations:_positionAnnotaionList];
    [_mapView addAnnotations:_positionAnnotaionList];
}

- (void)showPMDeviceView:(ISSVideoModel *)model {
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake([model.latitude doubleValue] , [model.longitude doubleValue]) animated:YES];
    
    if (_pMPopupView) {
        [_pMPopupView removeFromSuperview];
        _pMPopupView = nil;
    }
    __weak typeof(self) weakSelf = self;
    _pMPopupView = [[ISSMapPMPopupView alloc] init:!_selectedDeviceId];
    _pMPopupView.dissmissBlock = ^{
        [weakSelf dissmissPMPopupView];
    };
    _pMPopupView.showDetailBlock = ^(ISSMapEqiModel *model, NSInteger index) {
        [weakSelf showPMDetail:model tag:index];
    };
    [self.view addSubview:_pMPopupView];
    [_pMPopupView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(self.view);
        make.top.equalTo(@(CGRectGetHeight(self.view.frame)));
    }];
    _pMPopupView.model = model;
    
    [self performSelector:@selector(animatedShowPMPopupView) withObject:nil afterDelay:CGFLOAT_MIN];
}

- (void)animatedShowPMPopupView {
    [_pMPopupView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
    }];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}

- (void)dissmissPMPopupView {
    [_pMPopupView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(CGRectGetHeight(self.view.frame)));
    }];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         [_pMPopupView removeFromSuperview];
                         _pMPopupView = nil;
                         [weakSelf deselectAnnotation];
                     }];
}

- (void)showPMDetail:(ISSMapEqiModel *)model tag:(NSInteger)tag {
    switch (tag) {
        case 1: {
            ISSEnvironmentRealTimeViewController * realTimeVC = [[ISSEnvironmentRealTimeViewController alloc]init];
            realTimeVC.environmentListModel = (ISSEnvironmentListModel *)model;
            realTimeVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:realTimeVC animated:YES];
            
            break;
        }
            
        case 2: {
            ISSEnvironmentHistoryViewController * historyVC = [[ISSEnvironmentHistoryViewController alloc]init];
            historyVC.environmentListModel = (ISSEnvironmentListModel *)model;
            historyVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:historyVC animated:YES];
            
            break;
        }
            
        default:
            break;
    }
}

- (void)getEqiList {
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            _eqiList = [ISSMapEqiModel arrayOfModelsFromDictionaries:[result objectForKey:@"content"] error:nil];
        }
        [self.videoListManager loadData];
    }];
    [request getMapEqiList];
}

@end
