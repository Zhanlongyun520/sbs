//
//  ISSPlainAddLocationCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainAddLocationCell.h"

@implementation ISSPlainAddLocationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"plan-list-add"] forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
        [self.contentView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.keyLabel);
            make.width.equalTo(@44);
            make.top.right.bottom.equalTo(@0);
        }];
        
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.font = self.keyLabel.font;
        _valueLabel.textColor = self.keyLabel.textColor;
        _valueLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_valueLabel];
        [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.left.equalTo(self.keyLabel.mas_right);
            make.right.equalTo(button.mas_left);
        }];
    }
    return self;
}

@end
