//
//  ISSVideoPhotoCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/27.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSVideoPhotoCell.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ISSVideoPhotoCell ()
{
    UIImageView *_imageView;
}
@end

@implementation ISSVideoPhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setUrl:(NSURL *)url {
    _url = url;
    
    [_imageView sd_setImageWithURL:url];
}

@end
