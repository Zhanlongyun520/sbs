//
//  ISSUserInfoSexCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/28.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSUserInfoSexCell.h"

@interface ISSUserInfoSexCell ()
{
    UIButton *_maleButton;
    UIButton *_femaleButton;
}
@end

@implementation ISSUserInfoSexCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _femaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_femaleButton setTitle:@" 女" forState:UIControlStateNormal];
        [_femaleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _femaleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _femaleButton.tag = 0;
        [_femaleButton addTarget:self action:@selector(clickFemaleButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_femaleButton];
        [_femaleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(@0);
            make.width.equalTo(@60);
            make.height.equalTo(@55);
        }];
        
        _maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_maleButton setTitle:@" 男" forState:UIControlStateNormal];
        [_maleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _maleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _maleButton.imageEdgeInsets = _femaleButton.imageEdgeInsets;
        _maleButton.titleEdgeInsets = _femaleButton.titleEdgeInsets;
        _maleButton.tag = 0;
        [_maleButton addTarget:self action:@selector(clickMaleButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_maleButton];
        [_maleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_femaleButton);
            make.right.equalTo(_femaleButton.mas_left);
            make.width.equalTo(_femaleButton);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSex:(NSInteger)sex {
    _sex = sex;
    
    if (_sex == 0) {
        _maleButton.tag = 1;
        [_maleButton setImage:[UIImage imageNamed:@"ratioseltct"] forState:UIControlStateNormal];
        _femaleButton.tag = 0;
        [_femaleButton setImage:[UIImage imageNamed:@"ratio"] forState:UIControlStateNormal];
    } else {
        _maleButton.tag = 0;
        [_maleButton setImage:[UIImage imageNamed:@"ratio"] forState:UIControlStateNormal];
        _femaleButton.tag = 1;
        [_femaleButton setImage:[UIImage imageNamed:@"ratioseltct"] forState:UIControlStateNormal];
    }
}

- (void)clickMaleButton:(UIButton *)button {
    if (button.tag == 1) {
        return;
    }
    self.sex = 0;
    
    if (self.sexBlock) {
        self.sexBlock(self.sex);
    }
}

- (void)clickFemaleButton:(UIButton *)button {
    if (button.tag == 1) {
        return;
    }
    self.sex = 1;
    
    if (self.sexBlock) {
        self.sexBlock(self.sex);
    }
}

@end
