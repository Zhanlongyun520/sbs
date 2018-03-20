//
//  ISSUserInfoReadCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/28.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSUserInfoReadCell.h"

@implementation ISSUserInfoReadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.icon.image = [UIImage imageNamed:@"noedit"];
        self.keyLabel.textColor = [UIColor grayColor];
        self.textField.textColor = self.keyLabel.textColor;
        self.textField.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
