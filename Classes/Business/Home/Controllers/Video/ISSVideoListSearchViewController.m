//
//  ISSVideoListSearchViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/1.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSVideoListSearchViewController.h"
#import "ISSVideoListTableViewCell.h"
#import "APIVideoListManager.h"
#import "ISSVideoListReformer.h"

@interface ISSVideoListSearchViewController ()<UITableViewDelegate, UITableViewDataSource,APIManagerCallBackDelegate,UISearchBarDelegate>
{
    BOOL      isHeaderRefresh;
    BOOL      isFooterRefresh;
}

@property(nonatomic , strong) ISSRefreshTableView           * mainTableView;
@property(nonatomic , strong) APIVideoListManager           * videoListManager;
@property(nonatomic , strong) UISearchBar                   * searchBar;

@end

@implementation ISSVideoListSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"视屏监控";
    [self.view addSubview:self.mainTableView];
    
    [self navigationSetUp];
    [self.videoListManager loadData];
    
}

- (void)backToList
{
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navigationSetUp
{
    [self hiddenBackBarButtonItem];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:ISSColorWhite forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:ISSFont12];
    [cancelButton setFrame:CGRectMake(0, 0, 15, 20)];
    [cancelButton addTarget:self action:@selector(backToList) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    self.navigationItem.rightBarButtonItem = cancelItem;
    
    self.navigationItem.titleView = self.searchBar;
}


#pragma mark - ButtonAction
- (void)mapButtonAction:(UIButton *)button
{
    
}

- (void)realTimeButtonAction:(UIButton *)button
{
    
}

- (void)historyButtonAction:(UIButton *)button
{
    
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    if([manager isKindOfClass:[APIVideoListManager class]])
    {
        NSDictionary *dataDic = [manager fetchDataWithReformer:[[ISSVideoListReformer alloc]init]];
        NSLog(@"%@",dataDic);
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    ALERT(manager.errorMessage);
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 152;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ISSVideoListTableViewCell * cell = [[ISSVideoListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoList"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.mapButton addTarget:self action:@selector(mapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.realTimeButton addTarget:self action:@selector(realTimeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.historyButton addTarget:self action:@selector(historyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - Setter && Getter

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[ISSRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = ISSColorViewBg;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

- (APIVideoListManager *)videoListManager
{
    if (nil == _videoListManager) {
        _videoListManager = [[APIVideoListManager alloc] init];
        _videoListManager.delegate = self;
    }
    return _videoListManager;
}

- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        self.searchBar = [[UISearchBar alloc]init];
        _searchBar.delegate = self;
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.tintColor = ISSColorWhite;
        _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchBar.placeholder = @"请输入您要搜索的内容";
        _searchBar.keyboardType =  UIKeyboardTypeDefault;
        [_searchBar becomeFirstResponder];
    }
    return _searchBar;
}


@end
