//
//  LoadingManager.m
//
//
//  Created by WuLeilei.
//  Copyright (c) 2016年 WuLeilei. All rights reserved.
//

#import "LoadingManager.h"
#import "AppDelegate.h"
#import "UIView+Toast.h"

@interface LoadingManager ()
{
    NSUInteger _loadingCount;
    UIView *_loadingCoverView;
}
@end

@implementation LoadingManager

+ (instancetype)shareInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
	return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark Loading

- (void)startLoading {
    [self startLoadingInView:[UIApplication sharedApplication].keyWindow];
}

- (void)startLoadingInView:(UIView *)view {
    _loadingCount++;
    
    if (_loadingCount == 1) {
        if (!_loadingCoverView) {
            _loadingCoverView = [[UIView alloc] init];
            
            [_loadingCoverView makeToastActivity:CSToastPositionCenter];
        }
    } else {
        [_loadingCoverView removeFromSuperview];
    }
    _loadingCoverView.frame = view.bounds;
    [view addSubview:_loadingCoverView];
}

- (void)stopLoading {
    if (_loadingCount > 0) {
        _loadingCount--;
    }
    
    if (_loadingCount == 0) {
        [_loadingCoverView hideToastActivity];
        
        [_loadingCoverView removeFromSuperview];
        _loadingCoverView = nil;
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

@end
