//
//  ISSUVRequest.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/22.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UVError.h"

@interface ISSUVRequest : NSObject

#if OS_OBJECT_USE_OBJC
@property (atomic, strong, readwrite) dispatch_queue_t requestQueue;
#else
@property (atomic, assign, readwrite) dispatch_queue_t requestQueue;
#endif

- (id)init;

/** 实例化对象
 
 建议在使用前，均调用此静态方法
 
 @return UVRequest
 */
+ (ISSUVRequest*)instance;
- (void)execRequest:(void (^)())block_ finish:(void (^)(UVError *error))finish_;
- (void)execRequest:(void (^)())block_ finish:(void (^)(UVError *error))finish_ showProgressInView:(UIView*)view;
- (void)execRequest:(void (^)())block_ finish:(void (^)(UVError *error))finish_ showProgressInView:(UIView*)view message:(NSString*)message;
- (void)releaseQueue;

@end
