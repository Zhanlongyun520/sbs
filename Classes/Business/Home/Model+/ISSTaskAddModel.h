//
//  ISSTaskAddModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"

@interface ISSTaskAddModel : ISSBaseModel

@property(nonatomic, strong) NSString *taskName;
@property(nonatomic, strong) NSDate *startTime;
@property(nonatomic, strong) NSDate *endTime;
@property(nonatomic, strong) NSString *taskContent;
@property(nonatomic, strong) NSMutableArray *positionArray;
@property(nonatomic, strong) NSMutableArray *peopleArray;

@end
