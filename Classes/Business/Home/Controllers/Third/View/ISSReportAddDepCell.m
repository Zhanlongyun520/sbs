//
//  ISSReportAddDepCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportAddDepCell.h"

@implementation ISSReportAddDepCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textField.textAlignment = NSTextAlignmentRight;
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-45);
        }];
        
        [self.keyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@80);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
