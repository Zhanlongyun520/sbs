//
//  XTLoadingView.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/30.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "XTLoadingView.h"

@implementation XTLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _isAnimating = NO;
        
        UIImage *loadimage = [UIImage imageNamed:@"loading_more_1"];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - loadimage.size.width)/2,0, loadimage.size.width,loadimage.size.height)];

        [self addSubview:imageView];
        //设置动画帧
        imageView.animationImages=[NSArray arrayWithObjects:
                                   [UIImage imageNamed:@"loading_more_1"],
                                   [UIImage imageNamed:@"loading_more_2"],
                                   [UIImage imageNamed:@"loading_more_3"],
                                   [UIImage imageNamed:@"loading_more_4"],
                                   [UIImage imageNamed:@"loading_more_5"],
                                   [UIImage imageNamed:@"loading_more_6"],
                                   [UIImage imageNamed:@"loading_more_7"],
                                   [UIImage imageNamed:@"loading_more_8"],
                                   [UIImage imageNamed:@"loading_more_9"],
                                   [UIImage imageNamed:@"loading_more_10"],
                                   [UIImage imageNamed:@"loading_more_11"],
                                   [UIImage imageNamed:@"loading_more_12"],
                                   [UIImage imageNamed:@"loading_more_13"],
                                   [UIImage imageNamed:@"loading_more_14"],
                                   [UIImage imageNamed:@"loading_more_15"],
                                   [UIImage imageNamed:@"loading_more_16"],
                                   [UIImage imageNamed:@"loading_more_17"],
                                   
                                   nil];
        
        
        Infolabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
        Infolabel.backgroundColor = [UIColor clearColor];
        Infolabel.textAlignment = NSTextAlignmentCenter;
        Infolabel.textColor = [UIColor colorWithRed:84.0/255 green:86./255 blue:212./255 alpha:1];
        Infolabel.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:14.0f];
        [self addSubview:Infolabel];
        self.layer.hidden = YES;
    }
    return self;
}


- (void)startAnimation
{
    _isAnimating = YES;
    self.layer.hidden = NO;
    [self doAnimation];
}

- (void)doAnimation{
    
    Infolabel.text = _loadtext;
    //设置动画总时间
    imageView.animationDuration=1.0;
    //设置重复次数,0表示不重复
    imageView.animationRepeatCount=0;
    //开始动画
    [imageView startAnimating];
}

- (void)stopAnimationWithLoadText:(NSString *)text withType:(BOOL)type;
{
    _isAnimating = NO;
    Infolabel.text = text;
    if(type){
        
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [imageView stopAnimating];
            self.layer.hidden = YES;
            self.alpha = 1;
        }];
    }else{
        [imageView stopAnimating];
        [imageView setImage:[UIImage imageNamed:@"loading_more_17"]];
    }
    
}


- (void)setLoadText:(NSString *)text;
{
    if(text){
        _loadtext = text;
    }
}

@end
