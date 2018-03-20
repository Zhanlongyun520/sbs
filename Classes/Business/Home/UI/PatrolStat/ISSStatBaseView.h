//
//  ISSStatBaseView.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

#define kPatrolStatBlueColor [UIColor colorWithRed:0.00 green:0.25 blue:0.89 alpha:1.00]
#define kPatrolStatGrayColor [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1.00]
#define kPatrolStatLightBlueColor [UIColor colorWithRed:0.21 green:0.59 blue:0.99 alpha:1.00]
#define kPatrolStatOrangeColor [UIColor colorWithRed:0.99 green:0.57 blue:0.26 alpha:1.00]

@interface ISSStatBaseView : UIView
{
    UILabel *_titleLabel;
    
    UIButton *_dateButton;
    UIButton *_depButton;
    
    UIImageView *_data1ImageView;
    UIImageView *_data2ImageView;
    UILabel *_data1Label;
    UILabel *_data2Label;
    
    UIView *_contentView;
    
    UILabel *_emptyLabel;
}

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, copy) NSString *departmentId;

@property (nonatomic, copy) void (^showDatePickerBlock) (NSDate *date, NSInteger tag);

@property (nonatomic, copy) void (^showDepartmentPickerBlock) (NSString *departmentId, NSInteger tag);

@end
