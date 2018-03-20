//
//  ISSCarTrackViewController.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSCarTrackViewController.h"
#import "ISSCameraDetailViewController.h"
#import "ISSCarListModel.h"
#import "ISSCarListModel.h"
#import "Masonry.h"
#import "NetworkRequest.h"

#import "PGDatePicker.h"

#import "ISSCarTrackAnnotation.h"
#import "ISSHistoryTrackPopupView.h"

@interface ISSCarTrackViewController () <PGDatePickerDelegate>

@property (nonatomic, strong) NSArray *dateList;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIButton *dateBtn;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, assign) NSInteger currentDateIndex;
@property (nonatomic, strong) ISSHistoryTrackPopupView *popupView;

@end

@implementation ISSCarTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isHiddenTabBar = YES;
    
    self.navigationItem.title = self.model.licence;

    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"previous_btn"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:leftBtn];
    _leftBtn = leftBtn;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"next_btn"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:rightBtn];
    _rightBtn = rightBtn;
    
    UIButton *dateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    dateBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [dateBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [dateBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateDisabled];
//    [dateBtn addTarget:self action:@selector(selectDateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:dateBtn];
    _dateBtn = dateBtn;
    _dateBtn.enabled = NO;

    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.equalTo(@49);
    }];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@8);
        make.bottom.equalTo(@(-8));
    }];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@8);
        make.right.bottom.equalTo(@(-8));
    }];
    
    [dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(headerView);
        make.height.equalTo(headerView);
        make.width.equalTo(@120);
    }];

    // 开启定位
    _mapView.showsUserLocation = YES;
    [_mapView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(headerView.mas_bottom);
    }];
    
    [self checkBtnEnableStatus];
    
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {

        NSArray *dates = (NSArray *)result;
        _dateList = dates;
        
        if (dates.count > 0) {
            _dataSource = [NSMutableArray array];

            NSString *dateString = self.dateList.firstObject;
            [self.dateBtn setTitle:dateString forState:UIControlStateNormal];
            
            [self getTrackDetail:dateString];
        }
        
    }];
    [request getDateList:self.model.licence];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBtnAction:(UIButton *)btn {
    if (self.currentDateIndex < self.dateList.count) {
        NSString *dateString = self.dateList[self.currentDateIndex+1];
        [self reloadData:dateString];
        
        self.currentDateIndex ++;
    }
    [self checkBtnEnableStatus];
}

- (void)rightBtnAction:(UIButton *)btn {
    if (self.currentDateIndex > 0) {
        NSString *dateString = self.dateList[self.currentDateIndex-1];
        [self reloadData:dateString];
        
         self.currentDateIndex --;
    }
    [self checkBtnEnableStatus];
}

- (void)checkBtnEnableStatus {
    NSInteger selectedIndex = self.currentDateIndex;

    self.leftBtn.enabled = (self.dateList.count > 0) && (selectedIndex != self.dateList.count-1);
    self.rightBtn.enabled = (self.dateList.count > 0) &&  (selectedIndex != 0);
}

- (void)reloadData:(NSString *)dateString {
    [_mapView removeAnnotations:self.dataSource];
    [_mapView.overlays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_mapView removeOverlay:obj];
    }];
    
    [self.dateBtn setTitle:dateString forState:UIControlStateNormal];
    [self getTrackDetail:dateString];
}

- (void)selectDateBtnAction:(UIButton *)btn {
    PGDatePicker *datePicker = [[PGDatePicker alloc] init];
    datePicker.delegate = self;
    [datePicker showWithShadeBackgroud];
    datePicker.datePickerType = PGPickerViewType3;
    datePicker.datePickerMode = PGDatePickerModeDate;
    datePicker.minimumDate = [[self dateFormatter] dateFromString:self.dateList.lastObject];
    datePicker.maximumDate = [[self dateFormatter] dateFromString:self.dateList.firstObject];
    datePicker.titleLabel.text = @"请选择时间";

    NSDate *date = [[self dateFormatter] dateFromString:btn.currentTitle];
    [datePicker setDate:date];
}

- (NSDateFormatter *)dateFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    return formatter;
}

#pragma PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:dateComponents];

    NSString *dateString = [[self dateFormatter] stringFromDate:date];

    [self.dateBtn setTitle:dateString forState:UIControlStateNormal];
    [self reloadData:dateString];
}

- (void)getTrackDetail:(NSString *)date {
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        
        NSArray *dates = (NSArray *)result;
        
        [self.dataSource removeAllObjects];
        
        [dates enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            ISSCarTrackModel *model = [[ISSCarTrackModel alloc] initWithDictionary:dict error:nil];
            
            ISSCarTrackAnnotation *annotation = [[ISSCarTrackAnnotation alloc] init];
            annotation.coordinate = CLLocationCoordinate2DMake(model.latitude, model.longitude);
            annotation.model = model;
            [self.dataSource addObject:annotation];
        }];

        //在地图上添加大头针
        [_mapView addAnnotations:self.dataSource];
        [_mapView showAnnotations:self.dataSource animated:YES];
        
        
        CLLocationCoordinate2D commonPolylineCoords[self.dataSource.count];
        for (NSInteger i = 0; i < self.dataSource.count; i++) {
            ISSCarTrackAnnotation *annotation = self.dataSource[i];
            ISSCarTrackModel *model = annotation.model;
            commonPolylineCoords[i].latitude = model.latitude;
            commonPolylineCoords[i].longitude = model.longitude;
        }
        //在地图上添加折线对象
        MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:self.dataSource.count];
        [_mapView addOverlay:commonPolyline];

    }];
    [request getMapMarkers:self.model.licence takePhotoTime:date];
    
}


#pragma mark MAMapViewDelegate
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
    if ([overlay isKindOfClass:[ISSAreaPolyline class]]) {
        return [self getAreaPolylineRenderer:overlay];
    } else if ([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolyline *line = (MAPolyline *)overlay;
        
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:line];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0.25 green:0.41 blue:0.86 alpha:1.00];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}

//自定义大头针
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[ISSCarTrackAnnotation class]]) {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:((ISSCarTrackAnnotation *)annotation).selected ? @"camera-red" : @"camera-normal"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    if ([view isKindOfClass:[MAAnnotationView class]]) {
        for (ISSCarTrackAnnotation *an in self.dataSource) {
            an.selected = NO;
        }
        ISSCarTrackAnnotation *annotation = (ISSCarTrackAnnotation *)view.annotation;
        annotation.selected = YES;
        [mapView removeAnnotations:self.dataSource];
        [mapView addAnnotations:self.dataSource];
        
        [self showPopupView:annotation.model];
    }
}

- (void)deselectAnnotation {
    for (ISSCarTrackAnnotation *an in self.dataSource) {
        an.selected = NO;
    }
    [_mapView removeAnnotations:self.dataSource];
    [_mapView addAnnotations:self.dataSource];
}

- (void)showPopupView:(ISSCarTrackModel *)model {
    if (!_popupView) {
        __weak typeof(self) weakSelf = self;
        _popupView = [[ISSHistoryTrackPopupView alloc] init];
        _popupView.dissmissBlock = ^{
            [weakSelf dissmissPopupView];
        };
        _popupView.showDetailBlock = ^(ISSCarTrackModel *model) {
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
    
    [UIView animateWithDuration:0.2
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

- (void)showDetail:(ISSCarTrackModel *)model {
    ISSCameraDetailViewController *vc = [[ISSCameraDetailViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
