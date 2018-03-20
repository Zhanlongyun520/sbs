//
//  ISSPlainAddLocationContentCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainAddLocationContentCell.h"
#import "NSString+Size.h"
#import "ISSNewTaskAnnotation.h"

@interface ISSPlainAddLocationContentCell ()
{
    UIView *_cView;
}
@end

@implementation ISSPlainAddLocationContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _cView = [[UIView alloc] init];
        [self.contentView addSubview:_cView];
        [_cView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@5);
            make.top.equalTo(@5);
            make.right.bottom.equalTo(@-15);
            make.height.greaterThanOrEqualTo(@25);
        }];
    }
    return self;
}

- (void)setDataList:(NSMutableArray *)dataList {
    _dataList = dataList;
    
    for (UIView *view in _cView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat padding = 10;
    CGFloat margin = 10;
    CGFloat cWidth = kScreenWidth - 15 * 2;
    CGFloat previousMaxX = 0;
    UIFont *font = [UIFont systemFontOfSize:13];
    UILabel *previousView;
    for (NSInteger i = 0; i < dataList.count; i++) {
        ISSNewTaskAnnotation *model = [dataList objectAtIndex:i];
        NSString *text = model.title;
        CGFloat width = [text getWidthOfFont:font height:20] + padding * 2;
        
        BOOL newRow;
        CGFloat leaveWidth = cWidth - margin - previousMaxX;
        if (leaveWidth < width) { // 放不下
            if (previousMaxX == 0) { // 这行第一个
                width = leaveWidth;
            }
            newRow = YES;
        } else {
            newRow = !previousView;
        }
        
        if (newRow) {
            previousMaxX = width;
        } else {
            previousMaxX += width;
        }
        
        previousView = [self createLocationUnit:text
                                           font:font
                                          width:width
                                         margin:margin
                                   previousView:previousView
                                      superview:_cView
                                         newRow:newRow
                                         isLast:dataList.count - 1 == i];
        
        UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        removeButton.tag = i;
        [removeButton addTarget:self action:@selector(removeAddress:) forControlEvents:UIControlEventTouchUpInside];
        [removeButton setImage:[UIImage imageNamed:@"task-location-remove"] forState:UIControlStateNormal];
        [_cView addSubview:removeButton];
        [removeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@20);
            make.left.equalTo(previousView.mas_right).offset(-15);
            make.top.equalTo(previousView).offset(-5);
        }];
    }
}

- (UILabel *)createLocationUnit:(NSString *)text
                           font:(UIFont *)font
                          width:(CGFloat)width
                         margin:(CGFloat)margin
                   previousView:(UIView *)previousView
                      superview:(UIView *)superview
                         newRow:(BOOL)newRow
                         isLast:(BOOL)isLast {
    UILabel *label = [[UILabel alloc] init];
    label.layer.borderColor = [UIColor colorWithRed:0.33 green:0.48 blue:0.87 alpha:1.00].CGColor;
    label.layer.borderWidth = 0.5;
    label.layer.cornerRadius = 14;
    label.layer.masksToBounds = YES;
    label.text = text;
    label.font = font;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithRed:0.45 green:0.58 blue:0.89 alpha:1.00];
    label.textColor = [UIColor whiteColor];
    [superview addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width));
        make.height.equalTo(@28);
        if (newRow || !previousView) {
            make.left.equalTo(@(margin));
        } else {
            make.left.equalTo(previousView.mas_right).offset(margin);
        }
        if (newRow) {
            if (previousView) {
                make.top.equalTo(previousView.mas_bottom).offset(margin);
            } else {
                make.top.equalTo(@(margin));
            }
        } else {
            make.top.equalTo(previousView);
        }
        if (isLast) {
            make.bottom.equalTo(@0);
        }
    }];
    
    return label;
}

- (void)removeAddress:(UIButton *)button {
    if (self.removeBlock) {
        self.removeBlock(button.tag);
    }
}

@end
