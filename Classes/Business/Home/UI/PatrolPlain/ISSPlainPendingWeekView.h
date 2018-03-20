//
//  ISSPlainPendingWeekView.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPlanBlueColor [UIColor colorWithRed:0.46 green:0.57 blue:0.91 alpha:1.00]

@interface ISSPlainPendingWeekView : UIView

@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) BOOL whiteBg;

@property (nonatomic, strong, readonly) NSDate *startDate;
@property (nonatomic, strong, readonly) NSDate *endDate;

@property (nonatomic, copy) void (^previousWeekBlock) (NSDate *date);
@property (nonatomic, copy) void (^nextWeekBlock) (NSDate *date);
@property (nonatomic, copy) void (^clickDateBlock) (NSDate *date);

@end
