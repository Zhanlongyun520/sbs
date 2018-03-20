//
//  ISSPlainListModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"
#import "ISSPlainListCreatorModel.h"

typedef NS_ENUM(NSInteger, ISSPlainStatus) {
    ISSPlainStatusPendingSubmit = 1,
    ISSPlainStatusPendingApprove = 2,
    ISSPlainStatusPassed = 3,
    ISSPlainStatusReturned = 4
};

@interface ISSPlainListModel : ISSBaseModel

@property(nonatomic, strong) NSString *id;
@property(nonatomic, strong) NSString *date;
@property(nonatomic, strong) NSString *endDate;
@property(nonatomic, strong) NSString *startDate;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) ISSPlainListCreatorModel *creator;
@property(nonatomic, assign) ISSPlainStatus status;
@property(nonatomic, strong) NSString *statusDescription;
@property(nonatomic, assign) NSInteger weekOfYear;

- (UIColor *)getStatusColor;

@end
