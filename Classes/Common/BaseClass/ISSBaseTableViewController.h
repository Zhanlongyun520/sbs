//
//  ISSBaseTableViewController.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSViewController.h"
#import "Masonry.h"
#import <MJRefresh/MJRefresh.h>
#import "UIImageView+WebImage.h"
#import "NetworkRequest.h"
#import "UIView+Toast.h"

@interface ISSBaseTableViewController : ISSViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}

- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
