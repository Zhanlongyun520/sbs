//
//  ISSReportRInputCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportRInputCell.h"

@interface ISSReportRInputCell ()
{
    UIScrollView *_photoScrollView;
    UIView *_photoView;
}
@end

@implementation ISSReportRInputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.top.equalTo(@0);
            make.bottom.equalTo(@-15);
        }];
        
        _textView = [[SZTextView alloc] init];
        _textView.tag = 80;
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.placeholder = @"请输入内容";
        [bgView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
            make.top.equalTo(@5);
            make.height.equalTo(@80);
        }];
        
        UIImageView *line = [[UIImageView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        [bgView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.top.equalTo(_textView.mas_bottom).offset(10);
            make.height.equalTo(@1);
        }];
        
        _photoScrollView = [[UIScrollView alloc] init];
        _photoScrollView.showsHorizontalScrollIndicator = NO;
        [bgView addSubview:_photoScrollView];
        [_photoScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(line);
            make.top.equalTo(line.mas_bottom).offset(15);
            make.height.equalTo(@55);
            make.bottom.equalTo(@-15);
        }];
        
        _photoView = [[UIView alloc] init];
        [_photoScrollView addSubview:_photoView];
        [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_photoScrollView);
            make.height.equalTo(_photoScrollView);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPhotoArray:(NSMutableArray *)photoArray {
    _photoArray = photoArray;
    
    for (UIView *view in _photoView.subviews) {
        [view removeFromSuperview];
    }
    
    UIView *preView;
    //NSInteger maxCount = 10;
    NSInteger maxCount = 20;
    NSInteger count = _photoArray.count < maxCount ? (_photoArray.count + 1) : maxCount;
    for (NSInteger i = 0; i < count; i ++) {
        UIView *view;
        if (i == _photoArray.count) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setBackgroundImage:[UIImage imageNamed:@"report-attachment"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(showAddPhoto) forControlEvents:UIControlEventTouchUpInside];
            [_photoView addSubview:button];
            
            view = button;
        } else {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removePhoto:)]];
            [_photoView addSubview:imageView];
            
            imageView.image = [_photoArray objectAtIndex:i];
            
            view = imageView;
        }
        view.layer.borderWidth = 1;
        view.layer.borderColor = [UIColor colorWithRed:0.86 green:0.89 blue:0.99 alpha:1.00].CGColor;
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            make.width.equalTo(view.mas_height);
            if (preView) {
                make.left.equalTo(preView.mas_right).offset(10);
            } else {
                make.left.equalTo(@0);
            }
            if (i == count - 1) {
                make.right.equalTo(@0);
            }
        }];
        
        preView = view;
    }
}

- (void)showAddPhoto {
    if (self.addPhotoBlock) {
        self.addPhotoBlock();
    }
}

- (void)removePhoto:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag;
    
    if (self.removePhotoBlock) {
        self.removePhotoBlock(index);
    }
}

@end
