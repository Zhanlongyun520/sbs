//
//  ISSCameraManager.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/28.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISSUVRequest.h"
#import "UVServiceManager.h"
#import "UVLoginParam.h"
#import "UVUtils.h"
#import "UVStartLiveParam.h"
#import "UVStreamInfo.h"
#import "UVStreamPlayer.h"
#import "UVInfoManager.h"

@class MBProgressHUD;

@interface ISSCameraManager : NSObject

@property(nonatomic,readonly) UVServiceManager *service;
@property(nonatomic,readonly) ISSUVRequest *request;

+ (instancetype)shareInstance;
- (void)loginUV;

- (MBProgressHUD*)progress:(NSString*)mess;
- (void)hideProgress;
- (void)showMsg:(NSString*)msg_;
- (void)showError:(UVError*)error_;

@end
