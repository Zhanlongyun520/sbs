//
//  ISSReportReadViewController.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/22.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseTableViewController.h"
#import "ISSReportDetailModel.h"

@interface ISSReportReadViewController : ISSBaseTableViewController
{
    ISSReportDetailModel *_detailModel;
}

@property(nonatomic, strong) ISSReportDetailModel *thirdListModel;

@end
