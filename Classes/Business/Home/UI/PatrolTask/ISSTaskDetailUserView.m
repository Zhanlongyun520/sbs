//
//  ISSTaskDetailUserView.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTaskDetailUserView.h"
#import "Masonry.h"
#import "UIImageView+WebImage.h"

@interface ISSTaskDetailUserView () {
    UIImageView *_imageView;
    UILabel *_label;
}
@end

@implementation ISSTaskDetailUserView

- (instancetype)init {
    if (self = [super init]) {
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.cornerRadius = 18;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@36);
            make.top.equalTo(@10);
            make.centerX.equalTo(self);
        }];
        
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:11];
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.top.equalTo(_imageView.mas_bottom);
        }];
    }
    return self;
}

- (void)setModel:(ISSTaskPeopleModel *)model {
    _model = model;
    
    [_imageView setImageWithPath:model.imageData placeholder:@"default-head"];
    _label.text = model.name;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    
    if (_selected) {
        _label.textColor = [UIColor colorWithRed:0.22 green:0.41 blue:0.85 alpha:1.00];
        _imageView.layer.borderColor = _label.textColor.CGColor;
        _imageView.layer.borderWidth = 2;
    } else {
        _label.textColor = [UIColor darkTextColor];
        _imageView.layer.borderWidth = 0;
    }
}

@end
