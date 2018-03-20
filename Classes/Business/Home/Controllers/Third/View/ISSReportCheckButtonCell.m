//
//  ISSReportCheckButtonCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/25.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportCheckButtonCell.h"

@implementation ISSReportCheckButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
        
        NSArray *array = @[@"同意", @"拒绝"];
        NSMutableArray *bArray = @[].mutableCopy;
        [array enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.backgroundColor = [UIColor colorWithRed:0.21 green:0.39 blue:0.82 alpha:1.00];
            button.tag = idx;
            [button setTitle:text forState:UIControlStateNormal];
            [button setTintColor:[UIColor whiteColor]];
            [button addTarget:self action:@selector(doSubmit:) forControlEvents:UIControlEventTouchUpInside];
            button.layer.cornerRadius = 5;
            button.layer.masksToBounds = YES;
            [self.contentView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@15);
                make.bottom.equalTo(@-15);
                make.height.equalTo(@44);
            }];
            
            [bArray addObject:button];
        }];
        [bArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:15 tailSpacing:15];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)doSubmit:(UIButton *)button {
    if (self.submitBlock) {
        self.submitBlock(button.tag);
    }
}

@end
