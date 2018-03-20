//
//  ISSTaskListViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTaskListViewController.h"
#import "ISSPlainTaskListCell.h"
#import "APIPlainTaskListManager.h"
#import "ISSTaskListModel.h"
#import "ISSPlainAddViewController.h"
#import "ISSTaskDetailViewController.h"
#import "ISSLoginUserModel.h"
#import "IQKeyboardManager.h"
#import "ISSNewTaskAnnotation.h"

@interface ISSTaskListViewController () <APIManagerCallBackDelegate>
{
    NSInteger _currentPage;
    NSMutableArray *_dataArray;
    APIPlainTaskListManager *_taskListManager;
    
    UIView *_startView;
    ISSTaskListModel *_startModel;
}
@end

@implementation ISSTaskListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    self.navigationItem.title = @"巡查任务";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"task-list-add"] style:UIBarButtonItemStyleDone target:self action:@selector(showAdd)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    _dataArray = @[].mutableCopy;
    
    _taskListManager = [[APIPlainTaskListManager alloc] init];
    _taskListManager.delegate = self;
    
    _tableView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_tableView registerClass:[ISSPlainTaskListCell class] forCellReuseIdentifier:@"ISSPlainTaskListCell"];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = header;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_dataArray.count == 0) {
        [_tableView.mj_header beginRefreshing];
    } else {
        [self refreshData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    ISSPlainTaskListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSPlainTaskListCell" forIndexPath:indexPath];
    cell.taskModel = [_dataArray objectAtIndex:indexPath.row];
    cell.taskDetailBlock = ^(ISSTaskListModel *model) {
        [weakSelf showDetail:model];
    };
    cell.taskCopyBlock = ^(ISSTaskListModel *model) {
        [weakSelf showCopy:model];
    };
    return cell;
}

- (void)refreshData {
    _currentPage = 0;
    
    _tableView.mj_footer = nil;
    
    [self getData:YES];
}

- (void)getNextPage {
    _currentPage++;
    [self getData:NO];
}

- (void)getData:(BOOL)cleanData {
    _taskListManager.userId = [ISSLoginUserModel shareInstance].loginUser.id;
    _taskListManager.page = _currentPage;
    [_taskListManager loadData];
}

#pragma mark - APIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager {
    NSDictionary *result = [manager fetchDataWithReformer:nil];
    if ([manager isKindOfClass:[APIPlainTaskListManager class]]) {
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
        if (_tableView.mj_footer.isRefreshing) {
            [_tableView.mj_footer endRefreshing];
        }
        
        if (_currentPage == 0) {
            [_dataArray removeAllObjects];
        }
        
        NSArray *array = [ISSTaskListModel arrayOfModelsFromDictionaries:[result objectForKey:@"content"] error:nil];
        [_dataArray addObjectsFromArray:array];
        
        NSInteger totolPage = ceilf([[result objectForKey:@"totalElements"] integerValue] / 10.0);
        
        if (totolPage - 1 > _currentPage) {
            if (!_tableView.mj_footer) {
                _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getNextPage)];
            }
        } else {
            _tableView.mj_footer = nil;
        }
        
        [_tableView reloadData];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager {
    if ([manager isKindOfClass:[APIPlainTaskListManager class]]) {
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
        if (_tableView.mj_footer.isRefreshing) {
            [_tableView.mj_footer endRefreshing];
        }
    }
}

- (void)showAdd {
    ISSPlainAddViewController *viewController = [[ISSPlainAddViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)showDetail:(ISSTaskListModel *)model {
    if (model.taskStatus == 0) {
        [self showStart:model];
    } else {
        ISSTaskDetailViewController *viewController = [[ISSTaskDetailViewController alloc] init];
        viewController.taskId = model.taskId;
        viewController.taskName = model.taskName;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)showStart:(ISSTaskListModel *)model {
    _startModel = model;
    
    if (!_startView) {
        _startView = [[UIView alloc] init];
        _startView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _startView.alpha = 0.0;
        _startView.layer.cornerRadius = 3;
        _startView.layer.masksToBounds = YES;
        
        UIView *cView = [[UIView alloc] init];
        cView.backgroundColor = [UIColor whiteColor];
        [_startView addSubview:cView];
        [cView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@245);
            make.height.equalTo(@270);
            make.center.equalTo(_startView);
        }];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"task-list-start"]];
        [cView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@127);
            make.left.top.right.equalTo(@0);
        }];
        
        UILabel *tLabel = [[UILabel alloc] init];
        tLabel.textAlignment = NSTextAlignmentCenter;
        tLabel.font = [UIFont systemFontOfSize:15];
        tLabel.text = model.taskName;
        [cView addSubview:tLabel];
        [tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(imageView.mas_bottom).offset(20);
            make.height.equalTo(@20);
        }];
        
        UILabel *cLabel = [[UILabel alloc] init];
        cLabel.textAlignment = NSTextAlignmentCenter;
        cLabel.font = [UIFont systemFontOfSize:12];
        cLabel.textColor = [UIColor grayColor];
        cLabel.text = @"确认执行？";
        [cView addSubview:cLabel];
        [cLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(tLabel.mas_bottom);
            make.height.equalTo(@30);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"开始执行" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tintColor = [UIColor whiteColor];
        button.backgroundColor = [UIColor colorWithRed:0.24 green:0.39 blue:0.87 alpha:1.00];
        button.layer.cornerRadius = 5;
        [button addTarget:self action:@selector(doStart) forControlEvents:UIControlEventTouchUpInside];
        [cView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.height.equalTo(@40);
            make.bottom.equalTo(@-15);
            make.right.equalTo(@-20);
        }];
        
        UIButton *cButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [cButton setImage:[UIImage imageNamed:@"task-list-close"] forState:UIControlStateNormal];
        cButton.tintColor = [UIColor whiteColor];
        [cButton addTarget:self action:@selector(doClose) forControlEvents:UIControlEventTouchUpInside];
        [cView addSubview:cButton];
        [cButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(@0);
            make.width.height.equalTo(@30);
        }];
    }
    [self.navigationController.view addSubview:_startView];
    [_startView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.navigationController.view);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        _startView.alpha = 1.0;
    }];
}

- (void)doStart {
    [self doClose];
    
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            _startModel.taskStatus = ISSTaskStatusDoing;
            [weakSelf showDetail:_startModel];
        }
    }];
    [request startTask:_startModel.taskId taskName:_startModel.taskName];
}

- (void)doClose {
    [UIView animateWithDuration:0.25
                     animations:^{
                         _startView.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [_startView removeFromSuperview];
                     }];
}

- (void)showCopy:(ISSTaskListModel *)model {
    ISSTaskAddModel *addModel = [[ISSTaskAddModel alloc] init];
    
    addModel.taskName = model.taskName;
    
    for (ISSTaskPositionModel *pos in model.patrolPositions) {
        ISSNewTaskAnnotation *obj = [[ISSNewTaskAnnotation alloc] init];
        obj.coordinate = CLLocationCoordinate2DMake(pos.latitude, pos.longitude);
        obj.title = pos.position;
        [addModel.positionArray addObject:obj];
    }
    
    for (ISSTaskPeopleModel *user in model.users) {
        ISSTaskPeopleModel *obj = [[ISSTaskPeopleModel alloc] init];
        obj.id = user.id;
        obj.account = user.account;
        obj.imageData = user.imageData;
        [addModel.peopleArray addObject:obj];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    addModel.startTime = [formatter dateFromString:model.taskTimeStart];
    addModel.endTime = [formatter dateFromString:model.taskTimeEnd];
    
    addModel.taskContent = model.taskContent;
    
    ISSPlainAddViewController *viewController = [[ISSPlainAddViewController alloc] initWithStyle:UITableViewStylePlain];
    viewController.addModel = addModel;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
