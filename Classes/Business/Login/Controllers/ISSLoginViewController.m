//
//  ISSLoginViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSLoginViewController.h"
#import "ISSLoginView.h"

#import "ISSLoginUserModel.h"
#import "APIService.h"
#import "NetworkRequest.h"
#import "AppDelegate.h"
#import "LoadingManager.h"
#import "AppDelegate.h"

@interface ISSLoginViewController ()

@property(nonatomic,strong)ISSLoginView *loginView;

@end

@implementation ISSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    
    [self.view addSubview:self.loginView];
    [self.loginView.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *accountArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginAccount"];
    if (accountArray && accountArray.count == 2) {
        self.loginView.phoneTextField.text = [accountArray firstObject];
        self.loginView.verifyTextField.text = [accountArray lastObject];
    }
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:kApiBaseURL]];
    for (NSHTTPCookie *cookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}

- (void)login
{
    [self.view endEditing:YES];
    
#if TARGET_OS_SIMULATOR
    if (self.loginView.phoneTextField.text.length == 0 && self.loginView.verifyTextField.text.length == 0) {
        self.loginView.phoneTextField.text = @"admin";
        self.loginView.verifyTextField.text = @"bmeB4000";
    }
#endif
    
    NSString *name = self.loginView.phoneTextField.text;
    NSString *password = self.loginView.verifyTextField.text;
    
    NSString *tips = nil;
    if (name.length == 0) {
        tips = @"请输入账号";
    } else if (password.length == 0) {
        tips = @"请输入密码";
    }
    if (tips) {
        [self.view makeToast:tips];
        return;
    }
    
    [AppDelegate shareDelegate].name = name;
    [AppDelegate shareDelegate].password = password;
    
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            BOOL succ = [[result objectForKey:@"success"] boolValue];
            if (succ) {
                if (_loginView.checkButton.selected) {
                    [ISSLoginUserModel saveAccount:name password:password];
                } else {
                    [ISSLoginUserModel removeAccount];
                }
                
                [weakSelf getVideoInfo];
            } else {
                NSInteger code = [[result objectForKey:@"reason"] integerValue];
                NSString *message = nil;
                switch (code) {
                    case 1:
                        message = @"验证码超时";
                        break;
                        
                    case 2:
                        message = @"验证码不正确";
                        break;
                        
                    case 3:
                        message = @"用户名或密码错误"; // @"用户不存在";
                        break;
                        
                    case 4:
                        message = @"用户名或密码错误"; // @"密码错误";
                        break;
                        
                    case 5:
                        message = @"用户已锁定";
                        break;
                        
                    case 6:
                        message = @"密码过期";
                        break;
                        
                    default:
                        message = @"未知错误";
                        break;
                }
                if (message) {
                    [weakSelf.view makeToast:message];
                }
            }
        }
    }];
    [request doLogin:name password:password registrationID:[AppDelegate shareDelegate].registrationID];
}

- (void)getVideoInfo {
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            [[NSUserDefaults standardUserDefaults] setObject:result forKey:KVideoInformation];
        }
        [weakSelf getUserInfo];
    }];
    [request getVideoConfig];
}

- (void)getUserInfo {
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            ISSLoginUserModel *model = [[ISSLoginUserModel alloc] initWithDictionary:result error:nil];
            [ISSLoginUserModel shareInstance].loginUser = model.loginUser;
            [ISSLoginUserModel shareInstance].privilegeCode = model.privilegeCode;
            
            [(AppDelegate *)([UIApplication sharedApplication].delegate) registerJPush:model.loginUser.account];
        }
        [weakSelf.view endEditing:YES];
        [kDefaultCenter postNotificationName:kLoginSuccess object:nil];
    }];
    [request getUserInfo];
}

#pragma mark - Setter And Getter
- (ISSLoginView *)loginView
{
    if (_loginView == nil) {
        _loginView = [[ISSLoginView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    return _loginView;
}


@end
