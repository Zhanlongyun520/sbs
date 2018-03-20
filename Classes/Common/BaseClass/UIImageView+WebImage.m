//
//  UIImageView+WebImage.m
//  Templet
//
//  Created by WuLeilei.
//  Copyright © 2016年 WuLeilei. All rights reserved.
//

#import "UIImageView+WebImage.h"
#import "UIImageView+WebCache.h"
#import "APIService.h"

@implementation UIImageView (WebImage)

- (void)setImageWithPath:(NSString *)path {
    [self setImageWithPath:path placeholder:@"public_image_placeholder"];
}

- (void)setImageWithPath:(NSString *)path placeholder:(NSString *)placeholder {
    NSString *url = [UIImageView getFileURLString:path];
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundColor = [UIColor colorWithWhite:0.978 alpha:1.000];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholder]];
}

+ (NSString *)getFileURLString:(NSString *)path {
    NSString *urlString;
    if ([path hasPrefix:@"http://"] || [path hasPrefix:@"https://"]) {
        urlString = path;
    } else {
        urlString = [NSString stringWithFormat:@"%@%@", kImageBaseURL, path];
    }
    NSLog(@"%@", urlString);
    return urlString;
}

@end
