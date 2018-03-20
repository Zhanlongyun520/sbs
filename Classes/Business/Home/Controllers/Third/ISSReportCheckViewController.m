//
//  ISSReportCheckViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/25.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportCheckViewController.h"
#import "ISSReportAddViewController.h"
#import "ISSReportCheckCell.h"
#import "ISSReportReadViewController.h"
#import "ISSReportCheckDetailViewController.h"

@interface ISSReportCheckViewController ()

@end

@implementation ISSReportCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn setImage:[UIImage imageNamed:@"addreport"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addReport) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    [_tableView registerClass:[ISSReportCheckCell class] forCellReuseIdentifier:@"ISSReportCheckCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addReport {
    ISSReportAddViewController *viewController = [[ISSReportAddViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    ISSReportCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportCheckCell" forIndexPath:indexPath];
    cell.model = [_dataArray objectAtIndex:indexPath.row];
    cell.showDetailBlock = ^(NSInteger tag) {
        [weakSelf showDetail:tag index:indexPath.row];
    };
    return cell;
}

- (void)showDetail:(NSInteger)tag index:(NSInteger)index {
    ISSReportDetailModel *model = [_dataArray objectAtIndex:index];
    switch (tag) {
        case 0: {
            ISSReportReadViewController *viewController = [[ISSReportReadViewController alloc] init];
            viewController.thirdListModel = model;
            [self.navigationController pushViewController:viewController animated:YES];
            
            break;
        }
            
        case 1: {
            ISSReportCheckDetailViewController *viewController = [[ISSReportCheckDetailViewController alloc] init];
            viewController.thirdListModel = model;
            [self.navigationController pushViewController:viewController animated:YES];
            
            break;
        }
            
        default:
            break;
    }
}

@end
