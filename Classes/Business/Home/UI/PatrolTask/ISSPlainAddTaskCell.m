//
//  ISSPlainAddTaskCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainAddTaskCell.h"

@implementation ISSPlainAddTaskCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _textView = [[SZTextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
        _textView.placeholder = @"请输入内容";
        [self.contentView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@17);
            make.right.bottom.equalTo(@-17);
            make.top.equalTo(self.keyLabel.mas_bottom);
            make.height.equalTo(@150);
        }];
    }
    return self;
}

@end
