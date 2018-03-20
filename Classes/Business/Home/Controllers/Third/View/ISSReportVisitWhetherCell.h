//
//  ISSReportVisitWhetherCell.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainAddBaseCell.h"

@interface ISSReportVisitWhetherCell : ISSPlainAddBaseCell

@property (nonatomic, assign) BOOL needVisit;

@property (nonatomic, copy) void (^visitBlock) (BOOL visit);

@end
