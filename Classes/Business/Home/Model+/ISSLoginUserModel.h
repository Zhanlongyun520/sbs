//
//  ISSLoginUserModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"
#import "ISSTaskPeopleModel.h"
#import "ISSUserPrivilegeCode.h"

@interface ISSLoginUserModel : ISSBaseModel

@property(nonatomic, strong) ISSTaskPeopleModel *loginUser;
@property(nonatomic, strong) ISSUserPrivilegeCode *privilegeCode;

+ (instancetype)shareInstance;
+ (void)saveAccount:(NSString *)name password:(NSString *)password;
+ (NSString *)getAccountName;
+ (NSString *)getAccountPassword;
+ (void)removeAccount;

@end
