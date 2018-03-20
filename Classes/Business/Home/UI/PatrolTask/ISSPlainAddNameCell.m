//
//  ISSPlainAddNameCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainAddNameCell.h"

@implementation ISSPlainAddNameCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"请输入任务名称";
        _textField.textColor = self.keyLabel.textColor;
        _textField.font = self.keyLabel.font;
        _textField.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.height.equalTo(self.keyLabel);
            make.right.equalTo(@-15);
            make.left.equalTo(self.keyLabel.mas_right);
        }];
    }
    return self;
}

@end
