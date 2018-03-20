//
//  ISSTaskLocationViewController.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSMapBaseViewController.h"

@interface ISSTaskLocationViewController : ISSMapBaseViewController

@property (nonatomic, strong) NSMutableArray *selectedArray;

@property (nonatomic, copy) void (^selectedBlock) (NSArray *array);

@end
