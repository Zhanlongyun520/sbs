//
//  ISSTaskDetailViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTaskDetailViewController.h"
#import "APITaskDetailManager.h"
#import "ISSTaskListModel.h"
#import "ISSTaskDetailUserView.h"
#import "NetworkRequest.h"
#import "ISSUserPositionModel.h"
#import "ISSTrackPointAnnotation.h"
#import "ISSTaskDetailAnnotationView.h"
#import "ISSTaskDetailPopupView.h"
#import "UIView+Toast.h"
#import "ISSTaskDetailPolyline.h"
#import "ISSLoginUserModel.h"

@interface ISSTaskDetailViewController () <APIManagerCallBackDelegate>
{
    UIView *_userView;
    UIButton *_finishButton;
    
    NSMutableArray *_positionAnnotaionList;
    
    ISSTaskListModel *_detailModel;
    
    ISSTaskDetailPopupView *_popupView;
    
    CLLocationCoordinate2D _userCoordinate;
    
    ISSTaskDetailPolyline *_userPolyline;
}
@end

@implementation ISSTaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"任务详情";
    self.isHiddenTabBar = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _positionAnnotaionList = @[].mutableCopy;
    
    UIScrollView *tView = [[UIScrollView alloc] init];
    tView.showsHorizontalScrollIndicator = NO;
    tView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tView];
    [tView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.equalTo(@0);
        make.height.equalTo(@75);
        make.right.equalTo(@-100);
    }];
    
    _userView = [[UIView alloc] init];
    [tView addSubview:_userView];
    [_userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tView);
        make.height.equalTo(tView);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"任务完成" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.tintColor = [UIColor whiteColor];
    button.backgroundColor = [UIColor colorWithRed:0.24 green:0.39 blue:0.87 alpha:1.00];
    button.layer.cornerRadius = 5;
    button.hidden = YES;
    [button addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tView.mas_right).offset(15);
        make.height.equalTo(@25);
        make.width.equalTo(@-55);
        make.right.equalTo(@-15);
        make.centerY.equalTo(tView);
    }];
    _finishButton = button;
    
    _mapView.showsUserLocation = YES;
    [_mapView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(tView.mas_bottom);
    }];
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self performSelector:@selector(uploadUserTack) withObject:nil afterDelay:30];
}

- (void)viewWillDisappear:(BOOL)animated {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(uploadUserTack) object:nil];
    
    [super viewWillDisappear:animated];
}

#pragma mark 获取数据

- (void)getData {
    APITaskDetailManager *manager = [[APITaskDetailManager alloc] init];
    manager.taskId = _taskId;
    manager.delegate = self;
    [manager loadData];
}

#pragma mark - APIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager {
    NSDictionary *result = [manager fetchDataWithReformer:nil];
    if ([manager isKindOfClass:[APITaskDetailManager class]]) {
        _detailModel = [[ISSTaskListModel alloc] initWithDictionary:result error:nil];
        
        [self showDetails];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager {
    if ([manager isKindOfClass:[APITaskDetailManager class]]) {
        
    }
}

#pragma mark 显示详情

- (void)showDetails {
    [self showUsers];
    
    [self showPositions];
}

- (void)showPositions {
    if (_detailModel.patrolPositions.count == 0) {
        return;
    }
    
    // 显示任务地点
    [_mapView removeAnnotations:_positionAnnotaionList];
    [_positionAnnotaionList removeAllObjects];
    for (ISSTaskPositionModel *model in _detailModel.patrolPositions) {
        ISSTrackPointAnnotation *annotation = [[ISSTrackPointAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake(model.latitude, model.longitude);
        annotation.model = model;
        [_positionAnnotaionList addObject:annotation];
    }
    [_mapView addAnnotations:_positionAnnotaionList];
//    [_mapView showAnnotations:_positionAnnotaionList animated:YES];
}

#pragma mark MAMapViewDelegate

// 自定义大头针
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[ISSTrackPointAnnotation class]]) {
        static NSString *reuseIndetifier = @"ISSTaskDetailAnnotationView";
        ISSTaskDetailAnnotationView *annotationView = (ISSTaskDetailAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[ISSTaskDetailAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.centerOffset = CGPointMake(0, -7);
        
        ISSTrackPointAnnotation *theAnnotation = (ISSTrackPointAnnotation *)annotation;
        ISSTaskPositionModel *model = (ISSTaskPositionModel *)theAnnotation.model;
        if (theAnnotation.selected) { // 已选中的
            annotationView.image = [UIImage imageNamed:@"task-detail-point-selected"];
        } else { // 未选中的
            if (model.status == ISSTaskPositionStatusNew) {
                annotationView.image = [UIImage imageNamed:@"task-detail-point-red"];
            } else if (model.status == ISSTaskPositionStatusFinished) {
                annotationView.image = [UIImage imageNamed:@"task-detail-point-green"];
            }
        }
        
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    if ([view isKindOfClass:[ISSTaskDetailAnnotationView class]]) {
        for (ISSTrackPointAnnotation *an in _positionAnnotaionList) {
            an.selected = NO;
        }
        ISSTrackPointAnnotation *annotation = (ISSTrackPointAnnotation *)view.annotation;
        annotation.selected = YES;
        [mapView removeAnnotation:annotation];
        [mapView addAnnotation:annotation];
        
        [self showPopupView:annotation.model];
    }
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[ISSAreaPolyline class]]) {
        return [self getAreaPolylineRenderer:overlay];
    } else if ([overlay isKindOfClass:[ISSTaskDetailPolyline class]]) {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0.25 green:0.41 blue:0.86 alpha:1.00];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    if (updatingLocation) {
        _userCoordinate = userLocation.coordinate;
    }
}


#pragma mark 弹出框

- (void)showPopupView:(ISSTaskPositionModel *)model {
    if (!_popupView) {
        __weak typeof(self) weakSelf = self;
        _popupView = [[ISSTaskDetailPopupView alloc] init];
        _popupView.readonly = _readonly;
        _popupView.dissmissBlock = ^{
            [weakSelf dissmissPopupView];
        };
        _popupView.finishBlock = ^(ISSTaskPositionModel *model) {
            [weakSelf finishPosition:model];
        };
    }
    [self.view addSubview:_popupView];
    [_popupView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(self.view);
        make.top.equalTo(@(CGRectGetHeight(self.view.frame)));
    }];
    _popupView.model = model;
    
    [self performSelector:@selector(animatedShowPopupView) withObject:nil afterDelay:CGFLOAT_MIN];
}

- (void)animatedShowPopupView {
    [_popupView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
    }];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}

- (void)dissmissPopupView {
    [_popupView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(CGRectGetHeight(self.view.frame)));
    }];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         [_popupView removeFromSuperview];
                         [weakSelf deselectAnnotation];
                     }];
}

- (void)deselectAnnotation {
    for (ISSTrackPointAnnotation *an in _positionAnnotaionList) {
        an.selected = NO;
    }
    [_mapView removeAnnotations:_positionAnnotaionList];
    [_mapView addAnnotations:_positionAnnotaionList];
}

- (void)finishPosition:(ISSTaskPositionModel *)model {
    if (!CLLocationCoordinate2DIsValid(_userCoordinate)) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"定位失败"];
        return;
    }
    CLLocationCoordinate2D positionCorrdinate = CLLocationCoordinate2DMake(model.latitude, model.longitude);
    if (!CLLocationCoordinate2DIsValid(positionCorrdinate)) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"坐标无效"];
        return;
    }
    // 计算距离
    double maxDistance = 300;
    MAMapPoint point1 = MAMapPointForCoordinate(positionCorrdinate);
    MAMapPoint point2 = MAMapPointForCoordinate(_userCoordinate);
    CLLocationDistance distance = MAMetersBetweenMapPoints(point1, point2);
    if (distance > maxDistance) {
        [self.view makeToast:[NSString stringWithFormat:@"您距离任务点的距离为%@米，请在%@米以内执行操作", @(ceilf(distance)), @(maxDistance)]];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            [weakSelf dissmissPopupView];
            
            [weakSelf getData];
        }
    }];
    [request finishTaskPosition:model.id position:model.position];
}

#pragma mark 显示用户

- (void)showUsers {
    for (UIView *view in _userView.subviews) {
        [view removeFromSuperview];
    }
    
    UIView *previousView;
    for (NSInteger i = 0; i < _detailModel.users.count; i++) {
        ISSTaskPeopleModel *model = [_detailModel.users objectAtIndex:i];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickUser:)];
        
        ISSTaskDetailUserView *userView = [[ISSTaskDetailUserView alloc] init];
        userView.model = model;
        userView.tag = i;
        [userView addGestureRecognizer:tap];
        [_userView addSubview:userView];
        [userView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.width.equalTo(@50);
            if (previousView) {
                make.left.equalTo(previousView.mas_right).offset(5);
            } else {
                make.left.equalTo(@10);
            }
            if (i == _detailModel.users.count - 1) {
                make.right.equalTo(@-15);
            }
        }];
        
        previousView = userView;
        
        if ([model.id isEqualToString:[ISSLoginUserModel shareInstance].loginUser.id]) {
            [self clickUser:tap];
        }
    }
    
    if (_detailModel.taskStatus == ISSTaskStatusDone || _readonly) {
        _finishButton.hidden = YES;
        [_userView.superview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
        }];
    } else {
        _finishButton.hidden = NO;
    }
}

- (void)clickUser:(UITapGestureRecognizer *)tap {
    ISSTaskPeopleModel *userModel = [_detailModel.users objectAtIndex:tap.view.tag];
    
    for (ISSTaskDetailUserView *view in _userView.subviews) {
        view.selected = userModel == view.model;
    }
    
    [self getUserTackList:userModel];
}

#pragma mark 获取用户轨迹

- (void)getUserTackList:(ISSTaskPeopleModel *)userModel {
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        NSArray *pointArray;
        if (success) {
            pointArray = [ISSTaskPositionModel arrayOfModelsFromDictionaries:(NSArray *)result error:nil];
        }
        [weakSelf showUserTrack:pointArray];
    }];
    [request getUserTaskList:_detailModel.taskId userId:userModel.id];
}

- (void)showUserTrack:(NSArray *)userPositionList {
    // 移除之前的轨迹
    if (_userPolyline) {
        [_mapView removeOverlay:_userPolyline];
    }
    
    if (!userPositionList || userPositionList.count < 2) {
        [_mapView showOverlays:@[_areaPolyline] animated:YES];
        
        [self.view makeToast:@"没有获取到轨迹"];
        return;
    }
    
    //构造折线数据对象
    CLLocationCoordinate2D commonPolylineCoords[userPositionList.count];
    for (NSInteger i = 0; i < userPositionList.count; i++) {
        ISSTaskPositionModel *model = [userPositionList objectAtIndex:i];
        commonPolylineCoords[i].latitude = model.latitude;
        commonPolylineCoords[i].longitude = model.longitude;
    }
    
    //构造折线对象
    _userPolyline = [ISSTaskDetailPolyline polylineWithCoordinates:commonPolylineCoords count:userPositionList.count];
    
    //在地图上添加折线对象
    [_mapView addOverlay:_userPolyline];
    
    [_mapView showOverlays:@[_userPolyline, _areaPolyline] animated:YES];
}

#pragma mark 任务完成

- (void)finish {
    // 检查是否所有点都完成
    BOOL finished = YES;
    for (ISSTaskPositionModel *model in _detailModel.patrolPositions) {
        if (model.status == ISSTaskPositionStatusNew) {
            finished = NO;
            break;
        }
    }
    if (!finished) {
        [self.view makeToast:@"还有巡查点任务未完成，请先完成再执行此操作"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"任务完成？"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"否"
                                                        style:UIAlertActionStyleDefault
                                                      handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"是"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          [weakSelf finishTask];
                                                      }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)finishTask {
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            _detailModel.taskStatus = ISSTaskStatusDone;
            
            [weakSelf getData];
        }
    }];
    [request finishTask:_taskId taskName:_taskName];
}

- (void)uploadUserTack {
    if (!CLLocationCoordinate2DIsValid(_userCoordinate)) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            _detailModel.taskStatus = ISSTaskStatusDone;
            
            [weakSelf getData];
        }
        
        [weakSelf performSelector:@selector(uploadUserTack) withObject:nil afterDelay:30];
    }];
    [request uploadUserTrack:_taskId longitude:_userCoordinate.longitude latitude:_userCoordinate.latitude];
}

@end
