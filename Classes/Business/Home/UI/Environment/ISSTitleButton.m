//
//  ISSTitleButton.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTitleButton.h"

@implementation ISSTitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:ISSColorBlack forState:UIControlStateNormal];
        self.titleLabel.font = ISSFont14;
        [self setImage:[UIImage imageNamed:@"droparrow"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = 0;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame)+4;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.height = 20;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
    self.height = 20;
}

@end
