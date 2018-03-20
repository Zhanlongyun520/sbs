//
//  ISSPatrolReportViewController.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/25.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseTableViewController.h"

@interface ISSPatrolReportViewController : ISSBaseTableViewController
{
    NSMutableArray *_dataArray;
}

@property (nonatomic, assign) BOOL limitDep;

@end
