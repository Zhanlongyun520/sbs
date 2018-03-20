//
//  ISSPlainPendingHeaderView.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainPendingHeaderView.h"
#import "Masonry.h"

@implementation ISSPlainPendingHeaderView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        NSArray *tArray = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
        NSMutableArray *lArray = @[].mutableCopy;
        for (NSString *t in tArray) {
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:15];
            label.text = t;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.height.equalTo(@35);
            }];
            [lArray addObject:label];
        }
        [lArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:CGFLOAT_MIN leadSpacing:8 tailSpacing:8];
        
        UIImageView *line = [[UIImageView alloc] init];
        line.backgroundColor = [[UIColor colorWithRed:0.89 green:0.89 blue:0.90 alpha:1.00] colorWithAlphaComponent:0.5];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

@end
