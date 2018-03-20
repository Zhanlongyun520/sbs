//
//  ISSReportRSubmitCell.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseTableViewCell.h"

@interface ISSReportRSubmitCell : ISSBaseTableViewCell

@property (nonatomic, copy) void (^submitBlock) ();

@end
