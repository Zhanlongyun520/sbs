//
//  ISSPlainAddDateCell.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainAddBaseCell.h"

@interface ISSPlainAddDateCell : ISSPlainAddBaseCell

@property (nonatomic, strong) UILabel *startLabel;
@property (nonatomic, strong) UILabel *endLabel;

@property (nonatomic, copy) void (^showPickerBlock) (NSInteger tag);

@end
