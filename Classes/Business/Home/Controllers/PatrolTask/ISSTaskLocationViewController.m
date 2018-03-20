//
//  ISSTaskLocationViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTaskLocationViewController.h"
#import "ISSNewTaskAnnotation.h"
#import "ISSNewTaskAnnotationView.h"

@interface ISSTaskLocationViewController ()
{
    NSMutableArray *_pointList;
    
    UITextField *_textField;
    
    ISSNewTaskAnnotation *_newAnnotation;
}
@end

@implementation ISSTaskLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"任务地点";
    
    self.isHiddenTabBar = YES;
    
    _pointList = @[].mutableCopy;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"输入完成" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.tintColor = [UIColor whiteColor];
    button.backgroundColor = [UIColor colorWithRed:0.24 green:0.39 blue:0.87 alpha:1.00];
    button.layer.cornerRadius = 5;
    [button addTarget:self action:@selector(doneInput) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.height.equalTo(@40);
        make.bottom.equalTo(@-22);
        make.right.equalTo(@-15);
    }];
    
    _textField = [[UITextField alloc] init];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    _textField.layer.borderWidth = 1;
    _textField.layer.cornerRadius = 5;
    _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 1)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.placeholder = @"请输入巡查地点";
    [self.view addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.bottom.equalTo(button);
        make.left.equalTo(@15);
        make.right.equalTo(button.mas_left).offset(-10);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//自定义大头针
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[ISSNewTaskAnnotation class]]) {
        static NSString *reuseIndetifier = @"ISSNewTaskAnnotationView";
        ISSNewTaskAnnotationView *annotationView = (ISSNewTaskAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[ISSNewTaskAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.address = annotation.title;
        annotationView.centerOffset = CGPointMake(0, -25);
        
        ISSNewTaskAnnotation *theAnnotation = (ISSNewTaskAnnotation *)annotation;
        if (theAnnotation.title && theAnnotation.title.length > 0) { // 已保存的
            if (theAnnotation.selected) { // 已选中的
                annotationView.image = [UIImage imageNamed:@"task-map-point-remove"];
            } else { // 未选中的
                annotationView.image = [UIImage imageNamed:@"task-map-normal"];
            }
        } else { // 新的
            if (theAnnotation.selected) { // 已选中的
                annotationView.image = [UIImage imageNamed:@"task-map-point-new-remove"];
            } else { // 未选中的
                annotationView.image = [UIImage imageNamed:@"task-map-point-new"];
            }
        }
        
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    if ([view isKindOfClass:[ISSNewTaskAnnotationView class]]) {
        ISSNewTaskAnnotationView *annotationView = (ISSNewTaskAnnotationView *)view;
        ISSNewTaskAnnotation *annotation = annotationView.annotation;
        if (annotation.selected) { // 已选中的，则删除
            [mapView removeAnnotation:annotation];
        } else { // 未选中的，则选中
            annotation.selected = YES;
            [mapView removeAnnotation:annotation];
            [mapView addAnnotation:annotation];
        }
    }
}

- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    if (_newAnnotation) {
        [_mapView removeAnnotation:_newAnnotation];
        _newAnnotation = nil;
    }
    
    _newAnnotation = [[ISSNewTaskAnnotation alloc] init];
    _newAnnotation.coordinate = coordinate;
    [_mapView addAnnotation:_newAnnotation];
}

- (void)doneInput {
    [_textField resignFirstResponder];
    
    if (!_newAnnotation) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"没获取到坐标"];
        return;
    }
    
    NSString *text = _textField.text;
    if (text.length == 0) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入巡查地点"];
        return;
    }
    
    // 保存
    _newAnnotation.title = text;
    [_pointList addObject:_newAnnotation];
    
    // 刷新
    [_mapView removeAnnotation:_newAnnotation];
    [_mapView addAnnotation:_newAnnotation];
    
    // 重置
    _newAnnotation = nil;
    _textField.text = nil;
    
    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"保存成功"];
}

- (void)submit {
    if (_pointList.count == 0) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请先添加坐标信息再保存"];
        return;
    }
    
    if (self.selectedBlock) {
        self.selectedBlock(_pointList);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
