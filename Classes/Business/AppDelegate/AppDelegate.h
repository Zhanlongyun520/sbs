//
//  AppDelegate.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/9/28.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ISSTabBarController * tabBarController;

@property (copy, nonatomic) NSString *registrationID;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *password;

+ (AppDelegate *)shareDelegate;
- (void)registerJPush:(NSString *)keyword;

@end

