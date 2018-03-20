//
//  ISSReportAddModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"
#import "ISSReportCategoryModel.h"

@interface ISSReportAddModel : ISSBaseModel

//@property (nonatomic, strong) NSArray *addressList;
//@property (nonatomic, copy) NSString *address;
//@property (nonatomic, assign) NSInteger addressIndex;

@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) NSInteger addressTag;

@property (nonatomic, copy) NSString *dep;

@property (nonatomic, strong) NSArray *categoryList;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, assign) NSInteger categoryIndex;

@property (nonatomic, copy) NSString *construction;
@property (nonatomic, assign) NSInteger constructionTag;
@property (nonatomic, copy) NSString *implement;
@property (nonatomic, assign) NSInteger implementTag;
@property (nonatomic, copy) NSString *supervise;
@property (nonatomic, assign) NSInteger superviseTag;

@property (nonatomic, copy) NSString *users;
@property (nonatomic, assign) NSInteger usersTag;

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, copy) NSString *startTimeDes;
@property (nonatomic, strong) NSDate *endTime;
@property (nonatomic, copy) NSString *endTimeDes;


@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger titleTag;

@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger contentTag;

@property (nonatomic, assign) BOOL needVisit;

@property (nonatomic, strong) NSDate *time;
@property (nonatomic, copy) NSString *timeDes;

@end
