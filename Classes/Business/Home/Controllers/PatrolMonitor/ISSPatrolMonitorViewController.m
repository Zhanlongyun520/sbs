//
//  ISSPatrolMonitorViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPatrolMonitorViewController.h"
#import "APIMonitorTrackManager.h"
#import "ISSMonitorListModel.h"
#import "ISSTrackPointAnnotation.h"
#import "ISSTrackPopupView.h"
#import "APIPlainTaskListManager.h"
#import "ISSTaskDetailViewController.h"
#import "ISSTrackUserListViewController.h"
#import "IQKeyboardManager.h"

@interface ISSPatrolMonitorViewController () <APIManagerCallBackDelegate, APIManagerCallBackDelegate>
{
    NSArray *_dataList;
    
    NSMutableArray *_annotaionArray;
    
    ISSTrackPopupView *_popupView;
}
@end

@implementation ISSPatrolMonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    self.navigationItem.title = @"巡查人员实时监控";
    self.isHiddenTabBar = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"track-nav-more"] style:UIBarButtonItemStyleDone target:self action:@selector(showListViewController)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getData {
    APIMonitorTrackManager *manager = [[APIMonitorTrackManager alloc] init];
    manager.delegate = self;
    [manager loadData];
}

#pragma mark - APIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager {
    [self hiddenLoadingView];
    
    NSDictionary *result = [manager fetchDataWithReformer:nil];
    if ([manager isKindOfClass:[APIMonitorTrackManager class]]) {
        _dataList = [ISSMonitorListModel arrayOfModelsFromDictionaries:(NSArray *)result error:nil];
        [self showUsers];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager {
    [self hiddenLoadingView];
    
    if ([manager isKindOfClass:[APIMonitorTrackManager class]]) {
        
    }
}

#pragma mark 显示用户

- (void)showUsers {
    _annotaionArray = @[].mutableCopy;
    for (ISSMonitorListModel *model in _dataList) {
        ISSTrackPointAnnotation *annotation = [[ISSTrackPointAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake(model.latitude, model.longitude);
        annotation.model = model;
        [_annotaionArray addObject:annotation];
    }
    [_mapView addAnnotations:_annotaionArray];
//    [_mapView showAnnotations:_annotaionArray animated:YES];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[ISSTrackPointAnnotation class]]) {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:((ISSTrackPointAnnotation *)annotation).selected ? @"monitor-annotation-icon-selected" : @"monitor-annotation-icon"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        annotationView.tag = 100;
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    if ([view isKindOfClass:[MAAnnotationView class]] && view.tag == 100) {
        for (ISSTrackPointAnnotation *an in _annotaionArray) {
            an.selected = NO;
        }
        ISSTrackPointAnnotation *annotation = (ISSTrackPointAnnotation *)view.annotation;
        annotation.selected = YES;
        [mapView removeAnnotations:_annotaionArray];
        [mapView addAnnotations:_annotaionArray];
        
//        [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
//        [mapView setZoomLevel:13 animated:YES];
        
        [self showPopupView:annotation.model];
    }
}

- (void)deselectAnnotation {
    for (ISSTrackPointAnnotation *an in _annotaionArray) {
        an.selected = NO;
    }
    [_mapView removeAnnotations:_annotaionArray];
    [_mapView addAnnotations:_annotaionArray];
}

- (void)showPopupView:(ISSMonitorListModel *)model {
    if (!_popupView) {
        __weak typeof(self) weakSelf = self;
        _popupView = [[ISSTrackPopupView alloc] init];
        _popupView.dissmissBlock = ^{
            [weakSelf dissmissPopupView];
        };
        _popupView.showDetailBlock = ^(ISSTaskListModel *model) {
            [weakSelf showDetail:model];
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

- (void)showDetail:(ISSTaskListModel *)model {
    ISSTaskDetailViewController *viewController = [[ISSTaskDetailViewController alloc] init];
    viewController.taskId = model.taskId;
    viewController.taskName = model.taskName;
    viewController.readonly = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)showListViewController {
    ISSTrackUserListViewController *viewController = [[ISSTrackUserListViewController alloc] initWithStyle:UITableViewStylePlain];
    viewController.dataList = _dataList;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
