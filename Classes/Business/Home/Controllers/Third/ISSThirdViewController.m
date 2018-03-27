//
//  ISSThirdViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/25.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdViewController.h"
#import "HMSegmentedControl.h"
#import "Masonry.h"
#import "ISSPatrolReportViewController.h"
#import "ISSReportCheckViewController.h"
#import "ISSReportAddViewController.h"
#import "ISSLoginUserModel.h"

@interface ISSThirdViewController () <UIScrollViewDelegate>
{
    HMSegmentedControl *_segmentedControl;
    UIScrollView *_scrollView;
}
@end

@implementation ISSThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"三方协同消息";
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn setImage:[UIImage imageNamed:@"addreport"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addReport) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    NSMutableArray *titlesArray = @[].mutableCopy;
    
    BOOL patrolReport = [ISSLoginUserModel shareInstance].privilegeCode.M_PATROL_REPORT;
    BOOL reportAccept = [ISSLoginUserModel shareInstance].privilegeCode.M_PATROL_ACCEPT;
    if (patrolReport) {
        [titlesArray addObject:@"巡查报告"];
    }
    if (reportAccept) {
        [titlesArray addObject:@"报告验收"];
    }
    if (titlesArray.count == 0) {
        [self.view makeToast:@"没有权限"];
        return;
    }
    
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:titlesArray];
    _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentedControl.selectionIndicatorHeight = 2;
    _segmentedControl.selectionIndicatorColor = [UIColor colorWithRed:0.24 green:0.39 blue:0.87 alpha:1.00];
    _segmentedControl.verticalDividerEnabled = NO;
    _segmentedControl.backgroundColor = [UIColor whiteColor];
    _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor darkTextColor], NSFontAttributeName: [UIFont systemFontOfSize:15]};
    _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : _segmentedControl.selectionIndicatorColor};
    [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.height.equalTo(@44);
    }];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(_segmentedControl.mas_bottom);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    [_scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.height.equalTo(_scrollView);
        
    }];
    
    ISSPatrolReportViewController *patrolReportViewController;
    if ([ISSLoginUserModel shareInstance].privilegeCode.M_PATROL_REPORT) {
        patrolReportViewController = [[ISSPatrolReportViewController alloc] init];
        patrolReportViewController.limitDep = YES;
        [contentView addSubview:patrolReportViewController.view];
        [patrolReportViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (patrolReport && reportAccept) {
                make.left.top.bottom.equalTo(@0);
                make.width.equalTo(_scrollView);
            }
            else
            {
                make.bottom.top.right.equalTo(@0);
                make.width.equalTo(_scrollView);
                make.left.equalTo(@0);
            }
        }];
        [self addChildViewController:patrolReportViewController];
    }
    
    if ([ISSLoginUserModel shareInstance].privilegeCode.M_PATROL_ACCEPT) {
        ISSReportCheckViewController *reportCheckViewController = [[ISSReportCheckViewController alloc] init];
        reportCheckViewController.limitDep = NO;
        [contentView addSubview:reportCheckViewController.view];
        [reportCheckViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.right.equalTo(@0);
            make.width.equalTo(_scrollView);
            if (patrolReportViewController) {
                make.left.equalTo(patrolReportViewController.view.mas_right);
            } else {
                make.left.equalTo(@0);
            }
        }];
        [self addChildViewController:reportCheckViewController];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addReport {
    ISSReportAddViewController *viewController = [[ISSReportAddViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _scrollView) {
        NSUInteger page = scrollView.contentOffset.x / kScreenWidth;
        [scrollView setContentOffset:CGPointMake(kScreenWidth * page, scrollView.contentOffset.y) animated:YES];
        
        [_segmentedControl setSelectedSegmentIndex:page];
    }
}

- (void)segmentedControlChangedValue {
    NSInteger page = _segmentedControl.selectedSegmentIndex;
    [_scrollView setContentOffset:CGPointMake(kScreenWidth * page, _scrollView.contentOffset.y) animated:YES];
}

@end
