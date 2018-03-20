//
//  ISSCameraManager.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/28.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSCameraManager.h"
#import "NSObject+UVObjects.h"
#import "MBProgressHUD.h"

@interface ISSCameraManager ()
{
    MBProgressHUD *_hub;
}
@end

@implementation ISSCameraManager

- (MBProgressHUD*)progress:(NSString*)mess
{
    return [self progress:[UIApplication sharedApplication].keyWindow message:mess];
}
- (void)hideProgress
{
    if(_hub != nil)
    {
        [_hub hide:NO];
        _hub = nil;
    }
}

+ (instancetype)shareInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _service = [UVServiceManager instance];
        _request = [ISSUVRequest instance];
        
        
    }
    return self;
}

- (void)showMsg:(NSString*)msg_
{
    [[UIApplication sharedApplication].keyWindow makeToast:msg_];
}

- (void)showError:(UVError*)error_
{
    NSString *msg = [NSString stringWithFormat:@"%@ 错误码:%@",error_.message, @(error_.code)];
    [self showMsg:msg];
}

#pragma mark 宇视

- (void)loginUV {
    NSDictionary *serviceDic = [[NSUserDefaults standardUserDefaults] objectForKey:KVideoInformation];
    NSString *ip = [serviceDic objectForKey:@"ip"];
    int port = [[serviceDic objectForKey:@"port"] intValue];
    NSString *loginName = [serviceDic objectForKey:@"loginName"];
    NSString *loginPass = [serviceDic objectForKey:@"loginPass"];
    NSString *password = [UVUtils md5passwd:loginPass];
    
    UVLoginParam *loginparam = [[UVLoginParam alloc] init];
    [loginparam setServer:ip];//服务器 IP 地址
    [loginparam setPort:port];//服务器通信端口 默认是 52060
    [loginparam setUsername:loginName];//登录用户名
    [loginparam setPassword:password];//登录密码 需 要 32 位 md5 加密
    
    [self.request execRequest:^{
        [self.service login:loginparam];
    } finish:^(UVError *error) {
        if(error != nil) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"初始化视频组件失败"
                                                                                     message:error.message
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  
                                                              }]];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        } else {
            self.service.info.server = ip;
            self.service.info.mediaPort = 52062;
        }
    } showProgressInView:[UIApplication sharedApplication].keyWindow];
}

@end
