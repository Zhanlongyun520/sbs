//
//  ISSReportDetailCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/22.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportDetailCell.h"

@implementation ISSReportDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ISSKeyValueModel *)model {
    _model = model;
    
    self.textLabel.text = [NSString stringWithFormat:@"%@%@", model.key, model.value];
}

@end
