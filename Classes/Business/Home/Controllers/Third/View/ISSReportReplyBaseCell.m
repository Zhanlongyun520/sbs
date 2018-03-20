//
//  ISSReportReplyBaseCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/22.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportReplyBaseCell.h"
#import "NSString+Size.h"

@implementation ISSReportReplyBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor grayColor];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.left.right.equalTo(@0);
            make.height.equalTo(@20);
        }];
        
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.layer.cornerRadius = 20;
        _headerImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_headerImageView];
        [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_dateLabel.mas_bottom).offset(10);
            make.width.height.equalTo(@40);
        }];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headerImageView.mas_bottom);
            make.height.equalTo(@20);
            make.width.equalTo(@80);
        }];
        
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.font = [UIFont systemFontOfSize:11];
        _statusLabel.layer.cornerRadius = 3;
        _statusLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:_statusLabel];
        [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_headerImageView);
            make.height.equalTo(@15);
            make.top.equalTo(_nameLabel.mas_bottom);
        }];
        
        _bubbleImageView = [[UIImageView alloc] init];
        _bubbleImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_bubbleImageView];
        [_bubbleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headerImageView);
            make.bottom.equalTo(@-10);
            make.height.greaterThanOrEqualTo(@75);
        }];
        
        _userKeyLabel = [[UILabel alloc] init];
        _userKeyLabel.font = [UIFont systemFontOfSize:13];
        _userKeyLabel.textColor = [UIColor grayColor];
        [_bubbleImageView addSubview:_userKeyLabel];
        [_userKeyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.top.equalTo(@10);
            make.width.equalTo(@70);
        }];
        
        _userValueLabel = [[UILabel alloc] init];
        _userValueLabel.font = _userKeyLabel.font;
        _userValueLabel.textColor = [UIColor darkGrayColor];
        [_bubbleImageView addSubview:_userValueLabel];
        [_userValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userKeyLabel.mas_right);
            make.right.equalTo(@-12);
            make.top.bottom.equalTo(_userKeyLabel);
            make.height.equalTo(@0);
        }];
        
        _timeKeyLabel = [[UILabel alloc] init];
        _timeKeyLabel.font = _userKeyLabel.font;
        _timeKeyLabel.textColor = _userKeyLabel.textColor;
        [_bubbleImageView addSubview:_timeKeyLabel];
        [_timeKeyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_userKeyLabel);
            make.top.equalTo(_userKeyLabel.mas_bottom);
        }];
        
        _timeValueLabel = [[UILabel alloc] init];
        _timeValueLabel.font = _userValueLabel.font;
        _timeValueLabel.textColor = _userValueLabel.textColor;
        _timeValueLabel.numberOfLines = 0;
        [_bubbleImageView addSubview:_timeValueLabel];
        [_timeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_userValueLabel);
            make.top.bottom.equalTo(_timeKeyLabel);
            make.height.equalTo(@0);
        }];
        
        _lineImageView = [[UIImageView alloc] init];
        _lineImageView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
        [_bubbleImageView addSubview:_lineImageView];
        [_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_timeKeyLabel);
            make.right.equalTo(@-20);
            make.top.equalTo(_timeValueLabel.mas_bottom);
            make.height.equalTo(@1);
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.numberOfLines = 0;
        [_bubbleImageView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_lineImageView);
            make.top.equalTo(_lineImageView.mas_bottom).offset(8);
            make.height.equalTo(@0);
        }];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.textColor = [UIColor darkGrayColor];
        _contentLabel.numberOfLines = 0;
        [_bubbleImageView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_titleLabel);
            make.top.equalTo(_titleLabel.mas_bottom);
            make.height.equalTo(@0);
        }];
        
        _photoView = [[UIView alloc] init];
        [_bubbleImageView addSubview:_photoView];
        [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_lineImageView);
            make.top.equalTo(_contentLabel.mas_bottom);
            make.bottom.equalTo(@0);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ISSReportReplyModel *)model {
    _model = model;
    
    [_bubbleImageView updateConstraintsIfNeeded];
    [_bubbleImageView layoutIfNeeded];
    
    [self showData];
}

- (void)showData {
    _dateLabel.text = _model.date;
    [_headerImageView setImageWithPath:_model.creator.imageData placeholder:@"people"];
    _nameLabel.text = _model.creator.name;
    _statusLabel.text = _model.statusDes;
    _statusLabel.backgroundColor = [_model getStatusColor];
    _statusLabel.hidden = !_model.statusDes;
    
    if (_model.patrolUser.length > 0) {
        _userKeyLabel.text = @"巡查人员：";
        _userValueLabel.text = _model.patrolUser;
        
        CGFloat height = [_userValueLabel.text getHeightOfFont:_userValueLabel.font width:CGRectGetWidth(_userValueLabel.frame)];
        [_userValueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height + 14));
        }];
    } else {
        [_userValueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
    
    if (_model.patrolDateStart.length > 0) {
        _timeKeyLabel.text = @"巡查时间：";
        _timeValueLabel.text = [NSString stringWithFormat:@"%@\n%@", _model.patrolDateStart, _model.patrolDateEnd];
        
        CGFloat height = [_timeValueLabel.text getHeightOfFont:_timeValueLabel.font width:CGRectGetWidth(_timeValueLabel.frame)];
        [_timeValueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height + 14));
        }];
        
        _lineImageView.alpha = 1;
    } else {
        [_timeValueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        
        _lineImageView.alpha = 0;
    }
    
    if (_model.name.length > 0) {
        _titleLabel.text = _model.name;
        
        CGFloat height = [_titleLabel.text getHeightOfFont:_titleLabel.font width:CGRectGetWidth(_titleLabel.frame)];
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height));
        }];
    } else {
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
    
    if (_model.content.length > 0) {
        _contentLabel.text = _model.content;
        
        CGFloat height = [_contentLabel.text getHeightOfFont:_contentLabel.font width:CGRectGetWidth(_contentLabel.frame)];
        [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height + 20));
        }];
    } else {
        [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
    
    for (UIImageView *view in _photoView.subviews) {
        [view removeFromSuperview];
    }
    
    NSArray *dataArray = _model.smallFilesArray.count == 0 ? _model.filesArray : _model.smallFilesArray;
    if (dataArray.count > 0) {
        NSUInteger totalCount = dataArray.count;
        NSUInteger numbersOfRow = kR55 ? 4 : 3;
        NSUInteger rows = ceil(totalCount / (float)numbersOfRow);
        CGFloat horizontalLeadSpacing = CGFLOAT_MIN;
        CGFloat horizontalTailSpacing = CGFLOAT_MIN;
        CGFloat verticalLeadSpacing = 5.0f;
        CGFloat verticalTailSpacing = 15.0f;
        CGFloat itemHorizontalSpacing = 5.0f;
        CGFloat itemVerticalSpacing = 5.0f;
        CGFloat itemWidth = (CGRectGetWidth(_photoView.frame) - (numbersOfRow - 1) * itemHorizontalSpacing) / numbersOfRow;
        CGFloat itemHeight = itemWidth;
        UIView *previousView;
        for (NSUInteger i = 0; i < rows; i++) {
            NSMutableArray *rowViewArray = @[].mutableCopy;
            for (NSUInteger j = 0; j < numbersOfRow; j++) {
                UIImageView *imageView = [[UIImageView alloc] init];
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                imageView.clipsToBounds = YES;
                [_photoView addSubview:imageView];
                [rowViewArray addObject:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@(itemHeight));
                    if (j == 0) {
                        if (i == 0) {
                            make.top.equalTo(@(verticalLeadSpacing));
                        } else {
                            make.top.equalTo(previousView.mas_bottom).offset(itemVerticalSpacing);
                        }
                    } else {
                        make.top.equalTo(previousView);
                    }
                    if (i == rows - 1) {
                        make.bottom.equalTo(@(-verticalTailSpacing));
                    }
                }];
                
                NSUInteger index = i * numbersOfRow + j;
                if (index < totalCount) {
                    NSString *imageName = [dataArray objectAtIndex:index];
                    
                    imageView.tag = index;
                    [imageView setImageWithPath:imageName];
                    imageView.userInteractionEnabled = YES;
                    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPhoto:)]];
                } else {
                    imageView.hidden = YES;
                }
                
                previousView = imageView;
            }
            [rowViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:itemHorizontalSpacing leadSpacing:horizontalLeadSpacing tailSpacing:horizontalTailSpacing];
        }
    } else {
        
    }
    
    [_bubbleImageView updateConstraintsIfNeeded];
    [_bubbleImageView layoutIfNeeded];
}

- (void)clickPhoto:(UITapGestureRecognizer *)tap {
    if (self.showPhotoBlock) {
        self.showPhotoBlock(_model, tap.view.tag);
    }
}

@end
