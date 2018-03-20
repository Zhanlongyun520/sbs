//
//  ISSReportReplyModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/22.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"
#import "ISSTaskPeopleModel.h"

@interface ISSReportReplyModel : ISSBaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *statusDes;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *files;
@property (nonatomic, strong) NSArray *filesArray;
@property (nonatomic, copy) NSString *smallFiles;
@property (nonatomic, strong) NSArray *smallFilesArray;
@property (nonatomic, copy) NSString *patrolUser;
@property (nonatomic, copy) NSString *patrolDateStart;
@property (nonatomic, copy) NSString *patrolDateEnd;
@property (nonatomic, strong) ISSTaskPeopleModel *creator;

- (UIColor *)getStatusColor;

@end
