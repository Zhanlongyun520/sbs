//
//  ISSMapBaseViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/13.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSMapBaseViewController.h"

@interface ISSMapBaseViewController ()

@end

@implementation ISSMapBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView = [[MAMapView alloc] init];
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mapView.delegate = self;
    _mapView.zoomLevel = 13;
    _mapView.desiredAccuracy = kCLLocationAccuracyBest;
    // 开启定位
    _mapView.showsUserLocation = NO;
    // 追踪用户位置
    _mapView.userTrackingMode = MAUserTrackingModeNone;
    // 设置成NO表示关闭指南针；YES表示显示指南针
    _mapView.showsCompass = NO;
    [self.view addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
    }];
    
    [self createMapArea];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
    if ([overlay isKindOfClass:[ISSAreaPolyline class]]) {
        return [self getAreaPolylineRenderer:overlay];
    }
    return nil;
}

- (MAPolylineRenderer *)getAreaPolylineRenderer:(ISSAreaPolyline *)overlay {
    MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
    
    polylineRenderer.lineWidth    = 3.f;
    polylineRenderer.strokeColor  = [UIColor colorWithRed:0.14 green:0.35 blue:0.86 alpha:1.00];
    polylineRenderer.alpha = 0.9;
    polylineRenderer.lineJoinType = kMALineJoinRound;
    polylineRenderer.lineCapType  = kMALineCapRound;
    
    return polylineRenderer;
}

- (void)createMapArea {
    NSArray *mapAreaPointList = @[@[@114.479932, @30.490247],
                                  @[@114.483494, @30.491468],
                                  @[@114.486069, @30.492355],
                                  @[@114.488186, @30.492899],
                                  @[@114.492721, @30.493095],
                                  @[@114.502935, @30.492825],
                                  @[@114.507999, @30.492799],
                                  @[@114.51332, @30.493934],
                                  @[@114.518427, @30.495757],
                                  @[@114.5298, @30.500158],
                                  @[@114.533834, @30.490173],
                                  @[@114.53407, @30.456315],
                                  @[@114.504029, @30.447751],
                                  @[@114.481241, @30.447825],
                                  @[@114.481542, @30.484408] ,
                                  @[@114.479932, @30.490247]];
    
    //构造折线数据对象
    CLLocationCoordinate2D commonPolylineCoords[mapAreaPointList.count];
    for (NSInteger i = 0; i < mapAreaPointList.count; i++) {
        NSArray *coll = [mapAreaPointList objectAtIndex:i];
        double lat = [[coll lastObject] doubleValue];
        double lng = [[coll firstObject] doubleValue];
        commonPolylineCoords[i].latitude = lat;
        commonPolylineCoords[i].longitude = lng;
    }
    
    //构造折线对象
    _areaPolyline = [ISSAreaPolyline polylineWithCoordinates:commonPolylineCoords count:mapAreaPointList.count];
    
    //在地图上添加折线对象
    [_mapView addOverlay:_areaPolyline];
    
    // 设置中心点
    [_mapView showOverlays:@[_areaPolyline] animated:NO];
    [_mapView setZoomLevel:13 animated:YES];
}

@end
