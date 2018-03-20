//
//  ISSPlainAddLocationContentCell.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseTableViewCell.h"

@interface ISSPlainAddLocationContentCell : ISSBaseTableViewCell

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, copy) void (^removeBlock) (NSInteger index);
@end
