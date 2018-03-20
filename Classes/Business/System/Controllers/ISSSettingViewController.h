//
//  ISSSettingViewController.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSViewController.h"

@interface ISSSettingViewController : ISSViewController

+ (BOOL)isCarRecongizeOn;
+ (void)setCarRecongizeOn:(BOOL)isOn;

@end
