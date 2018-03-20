//
//  NSString+Size.h
//
//
//  Created by WuLeilei.
//  Copyright (c) 2016年 WuLeilei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)

- (CGFloat)getHeightOfFont:(UIFont *)textFont width:(CGFloat)textWidth;
- (CGFloat)getWidthOfFont:(UIFont *)textFont height:(CGFloat)textHeight;

@end
