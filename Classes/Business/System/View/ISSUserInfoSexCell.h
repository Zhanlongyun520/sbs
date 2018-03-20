//
//  ISSUserInfoSexCell.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/28.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSUserInfoBaseCell.h"

@interface ISSUserInfoSexCell : ISSUserInfoBaseCell

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, copy) void (^sexBlock) (NSInteger sex);

@end
