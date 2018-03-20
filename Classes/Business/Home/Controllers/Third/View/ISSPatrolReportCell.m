//
//  ISSPatrolReportCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/25.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPatrolReportCell.h"

@implementation ISSPatrolReportCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSArray *array = @[@{@"text": @"查看", @"image": @"viewdetail"},
                           @{@"text": @"回复", @"image": @"respond"},
                           @{@"text": @"回访", @"image": @"revisite"}];
        NSMutableArray *bArray = @[].mutableCopy;
        [array enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.translatesAutoresizingMaskIntoConstraints = NO;
            button.titleLabel.font = ISSFont12;
            button.tag = idx;
            [button setTitle:[dic objectForKey:@"text"] forState:UIControlStateNormal];
            [button setTitleColor:ISSColorNavigationBar forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[dic objectForKey:@"image"]]  forState:UIControlStateNormal];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(@0);
            }];
            
            [bArray addObject:button];
        }];
        [bArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:CGFLOAT_MIN leadSpacing:CGFLOAT_MIN tailSpacing:CGFLOAT_MIN];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
