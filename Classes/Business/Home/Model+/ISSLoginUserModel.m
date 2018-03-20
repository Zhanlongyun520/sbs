//
//  ISSLoginUserModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#define kLoginUser @"kLoginUserKey"
#define kLoginPassword @"kLoginPassword"

#import "ISSLoginUserModel.h"

@implementation ISSLoginUserModel

+ (instancetype)shareInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

+ (void)saveAccount:(NSString *)name password:(NSString *)password {
    [self.class removeAccount];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:name forKey:kLoginUser];
    [userDefaults setObject:password forKey:kLoginPassword];
    [userDefaults synchronize];
}

+ (NSString *)getAccountName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey:kLoginUser];
    return name;
}

+ (NSString *)getAccountPassword {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *password = [userDefaults objectForKey:kLoginPassword];
    return password;
}

+ (void)removeAccount {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:kLoginUser];
    [userDefaults removeObjectForKey:kLoginPassword];
    [userDefaults synchronize];
}

@end
