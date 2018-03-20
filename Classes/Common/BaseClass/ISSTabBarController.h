//
//  ISSTabBarController.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISSTabBarController : UITabBarController

@property(nonatomic,strong) UIImageView   * backGroundIV;

- (void)changeTabIndex:(NSInteger)index;
- (void)receiveNotification;

@end
