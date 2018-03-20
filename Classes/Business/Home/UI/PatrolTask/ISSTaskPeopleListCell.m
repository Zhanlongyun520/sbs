//
//  ISSTaskPeopleListCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTaskPeopleListCell.h"

@interface ISSTaskPeopleListCell () {
    UIImageView *_headerImageView;
    UILabel *_nameLabel;
    UIImageView *_selectImageView;
}
@end

@implementation ISSTaskPeopleListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.layer.cornerRadius = 17;
        _headerImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_headerImageView];
        [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@34);
            make.top.equalTo(@10);
            make.bottom.equalTo(@-10);
            make.left.equalTo(@15);
        }];
        
        _selectImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_selectImageView];
        [_selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@18);
            make.right.equalTo(@-40);
            make.centerY.equalTo(self.contentView);
        }];
        
        _nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.left.equalTo(_headerImageView.mas_right).offset(12);
            make.right.equalTo(_selectImageView.mas_left).offset(-10);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ISSTaskPeopleModel *)model {
    _model = model;
    
    _nameLabel.text = model.name;
    _selectImageView.image = [UIImage imageNamed:model.selected ? @"task-people-selected" : @"task-people-unselect"];
    
    [_headerImageView setImageWithPath:model.imageData placeholder:@"default-head"];
}

@end
