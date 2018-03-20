//
//  ISSEvidencePhotoModel.h
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"

@interface ISSPhotoUserModel : ISSBaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *imageData;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *fax;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *accountType;
@property (nonatomic, copy) NSString *locked;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *roles;
@property (nonatomic, copy) NSString *archs;

@end



@interface ISSEvidencePhotoModel : ISSBaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *licence;
@property (nonatomic, strong) ISSPhotoUserModel *takePhoroUser;
@property (nonatomic, copy) NSString *takePhotoTime;
@property (nonatomic, copy) NSString *addr;
@property (nonatomic, copy) NSString *photoSrc;
@property (nonatomic, copy) NSString *smallPhotoSrc;

@end

