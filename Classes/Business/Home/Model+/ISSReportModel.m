//
//  ISSReportModel.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/12/4.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportModel.h"

@implementation ISSReportModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.category = ToString(dic[@"category"]);
        self.content = ToString(dic[@"content"]);
        self.headName = ToString(dic[@"headName"]);
        self.imageData = ToString(dic[@"imageData"]);
        self.date = ToString(dic[@"date"]);
        self.name = ToString(dic[@"name"]);
        self.category = ToString(dic[@"category"]);
        self.patrolDateEnd = ToString(dic[@"patrolDateEnd"]);
        self.patrolDateStart = ToString(dic[@"patrolDateStart"]);
        self.patrolUser = ToString(dic[@"patrolUser"]);
        self.status = ToString(dic[@"status"]);
        
        if (dic[@"smallImages"]) {
            NSData *nsData = [dic[@"smallImages"] dataUsingEncoding:NSUTF8StringEncoding];
            self.smallImages= [NSJSONSerialization JSONObjectWithData:nsData options:kNilOptions error:nil];            
        }

    }
    return self;
}

@end
