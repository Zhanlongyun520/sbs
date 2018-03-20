//
//  AppDelegate.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/9/28.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "AppDelegate.h"
#import <MAMapKit/MAMapKit.h>

#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import "ISSHomeViewController.h"
#import "ISSTabBarController.h"
#import "ISSLoginViewController.h"
#import "NetworkRequest.h"

@interface AppDelegate () <JPUSHRegisterDelegate>

@end

@implementation AppDelegate


+ (AppDelegate *)shareDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions
                           appKey:JPush_AppKey
                          channel:nil
                 apsForProduction:YES
            advertisingIdentifier:nil];
    
    [kDefaultCenter addObserver:self selector:@selector(LoginSuccess) name:kLoginSuccess object:nil];
    [kDefaultCenter addObserver:self selector:@selector(LoginOut) name:kLoginOut object:nil];
    
    // 注册获取registrationID通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidLogin:)
                                                 name:kJPFNetworkDidLoginNotification
                                               object:nil];

    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    ISSLoginViewController * loginVC = [[ISSLoginViewController alloc]init];
    self.window.rootViewController = loginVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)LoginOut
{
    ISSLoginViewController * loginVC = [[ISSLoginViewController alloc]init];
    self.window.rootViewController = loginVC;
    [self.window makeKeyAndVisible];
}

- (void)LoginSuccess
{
    self.tabBarController = [[ISSTabBarController alloc]init];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

    NSLog(@"程序即将进入后台");
    if ([UIApplication sharedApplication].applicationIconBadgeNumber>0)
    {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    NSLog(@"程序即将进入前台");
    if ([UIApplication sharedApplication].applicationIconBadgeNumber>0) {
        
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    if ([UIApplication sharedApplication].applicationIconBadgeNumber>0) {
        
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 地图
- (void)initMapServices {
    [AMapServices sharedServices].apiKey = @"ecc98a7fb8c77d341ec7a36d2f3c10e5";
}

#pragma mark - JPush

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)registerJPush:(NSString *)keyword {
    [JPUSHService setAlias:keyword
                completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    NSLog(@"push: %@ %@ %@", @(iResCode), iAlias, @(seq));
                }
                       seq:99];
}

// 获取到 registrationID
- (void)networkDidLogin:(NSNotification *)notification {
    [AppDelegate shareDelegate].registrationID = [JPUSHService registrationID];
    NSLog(@"registrationID: %@", [AppDelegate shareDelegate].registrationID);
    
    // 调登录接口提交 registrationID
    if (_name && _password) {
        NetworkRequest *request = [[NetworkRequest alloc] init];
        [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
            if (success) {
                NSLog(@"registrationID 提交成功");
            }
        }];
        [request doLogin:_name password:_password registrationID:[AppDelegate shareDelegate].registrationID];
    }
}

@end
