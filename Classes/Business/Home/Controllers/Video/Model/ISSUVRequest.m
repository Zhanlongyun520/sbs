//
//  ISSUVRequest.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/22.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSUVRequest.h"
#import "NSObject+UVObjects.h"
#import "MBProgressHUD.h"

static ISSUVRequest *_requestinstance = nil;

@implementation ISSUVRequest

- (void)initData
{
    _requestQueue = dispatch_queue_create("_requestQueue", DISPATCH_QUEUE_CONCURRENT);
}

- (id)init
{
    if(self = [super init])
    {
        [self initData];
    }
    return self;
}
+ (ISSUVRequest*)instance
{
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        _requestinstance = [[ISSUVRequest alloc] init];
    });
    return _requestinstance;
}
- (void)execRequest:(void (^)())block_ finish:(void (^)(UVError *error))finish_
{
    [self execRequest:block_ finish:finish_ showProgressInView:nil message:nil];
}
- (void)execRequest:(void (^)())block_ finish:(void (^)(UVError *error))finish_ showProgressInView:(UIView*)view
{
    [self execRequest:block_ finish:finish_ showProgressInView:view message:@"加载中 ..."];
}
- (void)execRequest:(void (^)())block_ finish:(void (^)(UVError *error))finish_ showProgressInView:(UIView*)view message:(NSString*)message
{
    dispatch_async(_requestQueue, ^{
        UVError *err = nil;
        __block MBProgressHUD *hub = nil;
        if(view != nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                hub = [self progress:view message:message];
            });
        }
        @try {
            block_();
        }
        @catch (UVError *exception) {
            err = exception;
        }
        @catch (NSException *exception) {
            err = [UVError errorWithCode:UV_ERROR_COMMON_FAILURE];
        }
        @finally {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(hub != nil)
                {
                    [hub hide:NO];
                    hub = nil;
                }
                if(finish_ != nil)
                {
                    finish_(err);
                }
                
            });
        }
    });
}
- (void)releaseQueue
{
    if(_requestQueue!=nil)
    {
#if !OS_OBJECT_USE_OBJC
        dispatch_release(_requestQueue);
#endif
        _requestQueue = nil;
    }
}

@end
