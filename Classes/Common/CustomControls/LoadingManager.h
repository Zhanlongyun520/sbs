//
//  LoadingManager.h
//
//
//  Created by WuLeilei.
//  Copyright (c) 2016年 WuLeilei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LoadingManager : NSObject

+ (instancetype)shareInstance;
- (void)startLoading;
- (void)startLoadingInView:(UIView *)view;
- (void)stopLoading;

@end