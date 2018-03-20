//
//  ISSReportDetailModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/22.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"
#import "ISSTaskPeopleModel.h"

@interface ISSReportDetailModel : ISSBaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *categoryDes;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *constructionCompany;
@property (nonatomic, copy) NSString *developmentCompany;
@property (nonatomic, copy) NSString *supervisionCompany;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *statusDes;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *visitDate;
@property (nonatomic, assign) BOOL needVisit;
@property (nonatomic, strong) ISSTaskPeopleModel *creator;

- (UIColor *)getStatusColor;

@end
