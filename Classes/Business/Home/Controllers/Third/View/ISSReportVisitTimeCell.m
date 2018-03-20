//
//  ISSReportVisitTimeCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportVisitTimeCell.h"

@implementation ISSReportVisitTimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.keyLabel.text = @"回访时间";
        
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"data"];
        [self.contentView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@16);
            make.right.equalTo(@-15);
            make.centerY.equalTo(self.contentView);
        }];
        
        self.textField.userInteractionEnabled = NO;
        self.textField.textAlignment = NSTextAlignmentRight;
        self.textField.placeholder = @"填写时间";
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-45);
        }];
        
        [self.keyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@80);
        }];
        
        [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(@0);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
