//
//  ISSHomeFunctionTableViewCell.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/13.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISSHomeFunctionTableViewCell : UIView

@property (nonatomic, copy) void (^homeFunctionBlock) (NSInteger index);

+ (NSArray *)getHomeMenuData;

@end
