//
//  ISSTimeButton.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/3.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTimeButton.h"

@implementation ISSTimeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:ISSColorDardGray9 forState:UIControlStateNormal];
        self.titleLabel.font = ISSFont14;
        [self setImage:[UIImage imageNamed:@"data"] forState:UIControlStateNormal];
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
