//
//  ISSUserInfoHeadCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/28.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSUserInfoHeadCell.h"

@implementation ISSUserInfoHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        _header = [[UIImageView alloc]initForAutoLayout];
        _header.layer.cornerRadius = 25;
        _header.layer.masksToBounds = YES;
        [self.contentView addSubview:_header];
        [_header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@50);
            make.right.equalTo(@-5);
            make.top.equalTo(@10);
            make.bottom.equalTo(@-10);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
