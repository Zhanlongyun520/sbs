//
//  ISSThirdAddTimeTableViewCell.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/3.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSTimeButton.h"

@interface ISSThirdAddTimeTableViewCell : UITableViewCell

@property(nonatomic , strong)ISSTimeButton * startTimeButton;
@property(nonatomic , strong)ISSTimeButton * endTimeButton;

@end
