//
//  ISSReportCheckButtonCell.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/25.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseTableViewCell.h"

@interface ISSReportCheckButtonCell : ISSBaseTableViewCell

@property (nonatomic, copy) void (^submitBlock) (NSInteger index);

@end
