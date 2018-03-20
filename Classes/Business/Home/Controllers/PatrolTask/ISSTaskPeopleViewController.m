//
//  ISSTaskPeopleViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTaskPeopleViewController.h"
#import "APITaskPeopleListManager.h"
#import "ISSTaskPeopleModel.h"
#import "ISSTaskPeopleItemModel.h"
#import "ISSTaskPeopleListCell.h"
#import "DSectionIndexView.h"
#import "DSectionIndexItemView.h"

@interface ISSTaskPeopleViewController () <APIManagerCallBackDelegate, DSectionIndexViewDataSource, DSectionIndexViewDelegate>
{
    NSMutableArray *_dataArray;
    NSArray *_indexArray;
    
    DSectionIndexView *_sectionIndexView;
    UIView *_selectedView;
}
@end

@implementation ISSTaskPeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择人员";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    
    _dataArray = @[].mutableCopy;
    if (!_selectedArray) {
        _selectedArray = @[].mutableCopy;
    }
    
    UIScrollView *sView = [[UIScrollView alloc] init];
    sView.showsHorizontalScrollIndicator = NO;
    sView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sView];
    [sView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@55);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
    }];
    
    _selectedView = [[UIView alloc] init];
    [sView addSubview:_selectedView];
    [_selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sView);
        make.height.equalTo(sView);
    }];
    
    UIView *tView = [[UIView alloc] init];
    tView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tView];
    [tView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@60);
        make.top.equalTo(sView.mas_bottom).offset(2);
    }];
    
    UILabel *tLabel = [[UILabel alloc] init];
    tLabel.font = [UIFont systemFontOfSize:15];
    tLabel.text = @"请选择巡查人员";
    [tView addSubview:tLabel];
    [tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.bottom.equalTo(@0);
        make.top.equalTo(@15);
    }];
    
    _indexArray = @[@"↑", @"☆", @"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#"];
    
    [_tableView removeFromSuperview];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tView.mas_bottom);
        make.left.right.bottom.equalTo(@0);
    }];
    [_tableView registerClass:[ISSTaskPeopleListCell class] forCellReuseIdentifier:@"ISSTaskPeopleListCell"];
    
    _sectionIndexView = [[DSectionIndexView alloc] init];
    _sectionIndexView.backgroundColor = [UIColor clearColor];
    _sectionIndexView.dataSource = self;
    _sectionIndexView.delegate = self;
    _sectionIndexView.isShowCallout = NO;
    [self.view addSubview:_sectionIndexView];
    
    [self getData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_sectionIndexView reloadItemViews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [_sectionIndexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@40);
        make.right.equalTo(@0);
        make.top.bottom.equalTo(_tableView).offset(-60);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ISSTaskPeopleItemModel *model = [_dataArray objectAtIndex:section];
    return model.dataArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    ISSTaskPeopleItemModel *item = [_dataArray objectAtIndex:section];
    return item.firstLetter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ISSTaskPeopleItemModel *item = [_dataArray objectAtIndex:indexPath.section];
    ISSTaskPeopleModel *model = [item.dataArray objectAtIndex:indexPath.row];
    
    ISSTaskPeopleListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSTaskPeopleListCell" forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ISSTaskPeopleItemModel *item = [_dataArray objectAtIndex:indexPath.section];
    ISSTaskPeopleModel *model = [item.dataArray objectAtIndex:indexPath.row];
    model.selected = !model.selected;
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self reloadSelectedData];
}

#pragma mark DSectionIndexViewDataSource && delegate method

- (NSInteger)numberOfItemViewForSectionIndexView:(DSectionIndexView *)sectionIndexView {
    return _indexArray.count;
}

- (DSectionIndexItemView *)sectionIndexView:(DSectionIndexView *)sectionIndexView itemViewForSection:(NSInteger)section
{
    DSectionIndexItemView *itemView = [[DSectionIndexItemView alloc] init];
    itemView.titleLabel.text = [_indexArray objectAtIndex:section];
    itemView.titleLabel.font = [UIFont systemFontOfSize:12];
    itemView.titleLabel.textColor = [UIColor darkTextColor];

    return itemView;
}

- (void)sectionIndexView:(DSectionIndexView *)sectionIndexView didSelectSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else {
        NSString *idx = [_indexArray objectAtIndex:section];
        NSInteger index = -1;
        for (NSInteger i = 0; i < _dataArray.count; i++) {
            ISSTaskPeopleItemModel *model = [_dataArray objectAtIndex:i];
            if ([model.firstLetter isEqualToString:idx]) {
                index = i;
                break;
            }
        }
        if (index >= 0 && index < _dataArray.count) {
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        } else if (section == _indexArray.count - 1) {
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_dataArray.count - 1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }
}

- (void)getData {
    APITaskPeopleListManager *manager = [[APITaskPeopleListManager alloc] init];
    manager.delegate = self;
    [manager loadData];
}

#pragma mark - APIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager {
    NSDictionary *result = [manager fetchDataWithReformer:nil];
    if ([manager isKindOfClass:[APITaskPeopleListManager class]]) {
        NSArray *array = [ISSTaskPeopleModel arrayOfModelsFromDictionaries:(NSArray *)result error:nil];
        NSMutableArray *sortArray = [ISSTaskPeopleItemModel handleData:array];;
        _dataArray = sortArray;
        
        for (ISSTaskPeopleItemModel *item in _dataArray) {
            for (ISSTaskPeopleModel *model in item.dataArray) {
                for (ISSTaskPeopleModel *obj in _selectedArray) {
                    if ([obj.id isEqualToString:model.id]) {
                        model.selected = YES;
                        break;
                    }
                }
            }
        }
        
        [_tableView reloadData];
        [self reloadSelectedData];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager {
    if ([manager isKindOfClass:[APITaskPeopleListManager class]]) {
        
    }
}

- (void)reloadSelectedData {
    [_selectedArray removeAllObjects];
    for (ISSTaskPeopleItemModel *item in _dataArray) {
        for (ISSTaskPeopleModel *model in item.dataArray) {
            if (model.selected) {
                [_selectedArray addObject:model];
            }
        }
    }
    
    for (UIView *view in _selectedView.subviews) {
        [view removeFromSuperview];
    }
    
    UIImageView *previousView;
    for (NSInteger i = 0; i < _selectedArray.count; i++) {
        ISSTaskPeopleModel *model = [_selectedArray objectAtIndex:i];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.layer.cornerRadius = 20;
        imageView.layer.masksToBounds = YES;
        [imageView setImageWithPath:model.imageData placeholder:@"default-head"];
        [_selectedView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@40);
            make.centerY.equalTo(_selectedView);
            if (previousView) {
                make.left.equalTo(previousView.mas_right).offset(10);
            } else {
                make.left.equalTo(@10);
            }
            if (i == _selectedArray.count - 1) {
                make.right.equalTo(@-10);
            }
        }];
        
        previousView = imageView;
    }
}

- (void)submit {
    if (self.selectedBlock) {
        self.selectedBlock(_selectedArray);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
