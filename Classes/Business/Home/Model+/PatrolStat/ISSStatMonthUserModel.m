//
//  ISSStatMonthUserModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/12.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSStatMonthUserModel.h"

@implementation ISSStatMonthUserModel

- (void)setOffCount:(NSInteger)offCount {
    _offCount = offCount;
    
    _offCountDecimalNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", @(offCount)]];
}

@end
