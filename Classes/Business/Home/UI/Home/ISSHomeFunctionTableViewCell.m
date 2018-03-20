//
//  ISSHomeFunctionTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/13.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSHomeFunctionTableViewCell.h"
#import "Masonry.h"
#import "ISSLoginUserModel.h"

@interface ISSHomeFunctionTableViewCell()
{
    
}
@end

@implementation ISSHomeFunctionTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *dataArray = [self.class getHomeMenuData];
        
        NSUInteger totalCount = dataArray.count;
        NSUInteger numbersOfRow = 4;
        NSUInteger rows = ceil(totalCount / (float)numbersOfRow);
        CGFloat horizontalLeadSpacing = 20;
        CGFloat horizontalTailSpacing = 20;
        CGFloat verticalLeadSpacing = 10.0f;
        CGFloat verticalTailSpacing = 15.0f;
        CGFloat itemVerticalSpacing = 15.0f;
        CGFloat itemWidth = 68.0f;
        CGFloat itemHeight = 70.0f;
        UIView *previousView;
        for (NSUInteger i = 0; i < rows; i++) {
            NSMutableArray *rowViewArray = @[].mutableCopy;
            for (NSUInteger j = 0; j < numbersOfRow; j++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [self addSubview:button];
                [rowViewArray addObject:button];
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@(itemHeight));
                    if (j == 0) {
                        if (i == 0) {
                            make.top.equalTo(@(verticalLeadSpacing));
                        } else {
                            make.top.equalTo(previousView.mas_bottom).offset(itemVerticalSpacing);
                        }
                    } else {
                        make.top.equalTo(previousView);
                    }
                    if (i == rows - 1) {
                        make.bottom.equalTo(@(-verticalTailSpacing));
                    }
                }];
                
                NSUInteger index = i * numbersOfRow + j;
                if (index < totalCount) {
                    NSDictionary *dic = [dataArray objectAtIndex:index];
                    
                    button.tag = [[dic objectForKey:@"tag"] integerValue];
                    button.translatesAutoresizingMaskIntoConstraints = NO;
                    [button setTitle:[dic objectForKey:@"text"] forState:UIControlStateNormal];
                    [button setTitleColor:ISSColorDardGray6 forState:UIControlStateNormal];
                    button.titleLabel.font = ISSFont12;
                    [button setImage:[UIImage imageNamed:[dic objectForKey:@"image"]] forState:UIControlStateNormal];
                    [button setTitleEdgeInsets:UIEdgeInsetsMake(53, -39, 0, 0)];
                    [button setImageEdgeInsets:UIEdgeInsetsMake(-20, 14, 0, 0)];
                    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
                } else {
                    button.hidden = YES;
                }
                
                previousView = button;
            }
            [rowViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:itemWidth leadSpacing:horizontalLeadSpacing tailSpacing:horizontalTailSpacing];
        }
    }
    return self;
}

- (void)clickButton:(UIButton *)button {
    if (self.homeFunctionBlock) {
        self.homeFunctionBlock(button.tag);
    }
}

+ (NSArray *)getHomeMenuData {
    NSMutableArray *dataArray = @[].mutableCopy;
    
    if ([ISSLoginUserModel shareInstance].privilegeCode.VS) {
        [dataArray addObject:@{@"image": @"home-video", @"text": @"视屏监控", @"tag": @(0)}];
    }
    if ([ISSLoginUserModel shareInstance].privilegeCode.ENVIRMENT_VIEW) {
        [dataArray addObject:@{@"image": @"home-environment", @"text": @"环境监测", @"tag": @(1)}];
    }
    if ([ISSLoginUserModel shareInstance].privilegeCode.M_PATROL) {
        [dataArray addObject:@{@"image": @"home-third", @"text": @"三方协同", @"tag": @(2)}];
    }
    if ([ISSLoginUserModel shareInstance].privilegeCode.MUCKCAR_MONITOR) {
        [dataArray addObject:@{@"image": @"home-car-monitor", @"text": @"渣土车监控", @"tag": @(3)}];
    }
    if ([ISSLoginUserModel shareInstance].privilegeCode.M_CPINFO) {
        [dataArray addObject:@{@"image": @"home-patrol-status", @"text": @"巡查概况", @"tag": @(4)}];
    }
    if ([ISSLoginUserModel shareInstance].privilegeCode.M_CPP ||
        [ISSLoginUserModel shareInstance].privilegeCode.M_CPPA) {
        [dataArray addObject:@{@"image": @"home-patrol-plain", @"text": @"巡查计划", @"tag": @(5)}];
    }
    if ([ISSLoginUserModel shareInstance].privilegeCode.M_CPT) {
        [dataArray addObject:@{@"image": @"home-patrol-task", @"text": @"巡查任务", @"tag": @(6)}];
    }
    if ([ISSLoginUserModel shareInstance].privilegeCode.M_CPM) {
        [dataArray addObject:@{@"image": @"home-patrol-monitor", @"text": @"巡查监控", @"tag": @(7)}];
    }
    
    return dataArray;
}

@end
