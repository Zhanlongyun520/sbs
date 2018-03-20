//
//  ISSPlainAddPeopleCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainAddPeopleCell.h"
#import "ISSTaskPeopleModel.h"

@interface ISSPlainAddPeopleCell ()
{
    UIView *_selectedView;
}
@end

@implementation ISSPlainAddPeopleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIScrollView *sView = [[UIScrollView alloc] init];
        sView.showsHorizontalScrollIndicator = NO;
        sView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:sView];
        [sView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
            make.height.equalTo(@54);
        }];
        
        _selectedView = [[UIView alloc] init];
        [sView addSubview:_selectedView];
        [_selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(sView);
            make.height.equalTo(sView);
        }];
    }
    return self;
}

- (void)setDataList:(NSMutableArray *)dataList {
    _dataList = dataList;

    for (UIView *view in _selectedView.subviews) {
        [view removeFromSuperview];
    }
    
    UIImageView *previousView;
    for (NSInteger i = 0; i < _dataList.count; i++) {
        ISSTaskPeopleModel *model = [_dataList objectAtIndex:i];
        
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
            if (i == _dataList.count - 1) {
                make.right.equalTo(@-10);
            }
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button addTarget:self action:@selector(removePeople:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"task-p-remove"] forState:UIControlStateNormal];
        [_selectedView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@25);
            make.top.equalTo(@0);
            make.right.equalTo(imageView);
        }];
        
        previousView = imageView;
    }
}

- (void)removePeople:(UIButton *)button {
    NSInteger index = button.tag;
    if (index >= 0 && index < _dataList.count) {
        [_dataList removeObjectAtIndex:index];
    }
    
    [self setDataList:_dataList];
}

@end
