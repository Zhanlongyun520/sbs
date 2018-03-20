//
//  ISSReportVisitWhetherCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportVisitWhetherCell.h"

@interface ISSReportVisitWhetherCell ()
{
    UIButton *_yesButton;
    UIButton *_noButton;
}
@end

@implementation ISSReportVisitWhetherCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.keyLabel.text = @"是否回访";
        
        _noButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_noButton setTitle:@" 否" forState:UIControlStateNormal];
        [_noButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _noButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _noButton.tag = 0;
        [_noButton addTarget:self action:@selector(clickNoButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_noButton];
        [_noButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(@0);
            make.width.equalTo(@60);
            make.height.equalTo(@55);
        }];
        
        _yesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_yesButton setTitle:@" 是" forState:UIControlStateNormal];
        [_yesButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _yesButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _yesButton.imageEdgeInsets = _noButton.imageEdgeInsets;
        _yesButton.titleEdgeInsets = _noButton.titleEdgeInsets;
        _yesButton.tag = 0;
        [_yesButton addTarget:self action:@selector(clickYesButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_yesButton];
        [_yesButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_noButton);
            make.right.equalTo(_noButton.mas_left);
            make.width.equalTo(_noButton);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNeedVisit:(BOOL)needVisit {
    _needVisit = needVisit;
    
    if (_needVisit) {
        _yesButton.tag = 1;
        [_yesButton setImage:[UIImage imageNamed:@"ratioseltct"] forState:UIControlStateNormal];
        _noButton.tag = 0;
        [_noButton setImage:[UIImage imageNamed:@"ratio"] forState:UIControlStateNormal];
    } else {
        _yesButton.tag = 0;
        [_yesButton setImage:[UIImage imageNamed:@"ratio"] forState:UIControlStateNormal];
        _noButton.tag = 1;
        [_noButton setImage:[UIImage imageNamed:@"ratioseltct"] forState:UIControlStateNormal];
    }
}

- (void)clickYesButton:(UIButton *)button {
    if (button.tag == 1) {
        return;
    }
    self.needVisit = YES;
    
    if (self.visitBlock) {
        self.visitBlock(self.needVisit);
    }
}

- (void)clickNoButton:(UIButton *)button {
    if (button.tag == 1) {
        return;
    }
    self.needVisit = NO;
    
    if (self.visitBlock) {
        self.visitBlock(self.needVisit);
    }
}

@end
