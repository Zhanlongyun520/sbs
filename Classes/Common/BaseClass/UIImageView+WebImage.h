//
//  UIImageView+WebImage.h
//  Templet
//
//  Created by WuLeilei.
//  Copyright © 2016年 WuLeilei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebImage)

- (void)setImageWithPath:(NSString *)path;
- (void)setImageWithPath:(NSString *)path placeholder:(NSString *)placeholder;

+ (NSString *)getFileURLString:(NSString *)path;

@end
