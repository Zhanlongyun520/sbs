//
//  XTPickView.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/30.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTPickView;
@protocol XTPickViewDelegate <NSObject>

- (void)pickerView:(XTPickView *)pickerView didSelectRow:(NSString *)selectTimeString;

@end


typedef NS_ENUM(NSInteger, PickViewDataType) {
    PickViewDataTypeTime,
    PickViewDataTypeArea,
    PickViewDataTypeBusinessTime
};

@interface XTPickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate>

@property (strong,nonatomic) NSArray                * dataArray;
@property (strong,nonatomic) NSString               * titleString;
@property (assign,nonatomic) id<XTPickViewDelegate>   delegate;


- (instancetype)initWithTitle:(NSString *)title delegate:(id <XTPickViewDelegate>)delegate pickViewDataType:(PickViewDataType)pvType;

- (void)presentViewController:(UIViewController *)controller;

@end
