//
//  XTLoadingView.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/30.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTLoadingView : UIView
{
    UIImageView *imageView;
    UILabel *Infolabel;
}

@property (nonatomic, assign)   NSString    * loadtext;
@property (nonatomic, readonly) BOOL          isAnimating;


- (id)initWithFrame:(CGRect)frame;
-(void)setLoadText:(NSString *)text;

- (void)startAnimation;
- (void)stopAnimationWithLoadText:(NSString *)text withType:(BOOL)type;

@end
