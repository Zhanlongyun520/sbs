//
//  ISSTaskPeopleModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"

@protocol ISSTaskPeopleModel

@end

@interface ISSTaskPeopleModel : ISSBaseModel

@property(nonatomic, copy) NSString *account;
@property(nonatomic, assign) NSInteger accountType;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *des;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *fax;
@property(nonatomic, copy) NSString *id;
@property(nonatomic, copy) NSString *imageData;
@property(nonatomic, assign) BOOL locked;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) NSInteger sex;
@property(nonatomic, copy) NSString *telephone;
@property(nonatomic, copy) NSString *departmentId;

@property(nonatomic, strong) NSString *companyName;

@property(nonatomic, assign) BOOL selected;

@end
