//
//  ISSSettingsNotificationCell.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2018/1/14.
//  Copyright © 2018年 iSoftStone. All rights reserved.
//

#import "ISSBaseTableViewCell.h"

@interface ISSSettingsNotificationCell : ISSBaseTableViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UISwitch *theSwitch;

@property (nonatomic, copy) void (^changeSwitch)(BOOL isOn);

@end
