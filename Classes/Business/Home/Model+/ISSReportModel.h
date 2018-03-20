//
//  ISSReportModel.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/12/4.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISSReportModel : NSObject


@property(nonatomic, strong)NSString     * category;
@property(nonatomic, strong)NSString     * content;
@property(nonatomic, strong)NSString     * headName;
@property(nonatomic, strong)NSString     * imageData;

@property(nonatomic, strong)NSString     * date;
@property(nonatomic, strong)NSString     * name;
@property(nonatomic, strong)NSString     * patrolDateEnd;

@property(nonatomic, strong)NSString     * patrolDateStart;
@property(nonatomic, strong)NSString     * patrolUser;
@property(nonatomic, strong)NSString     * status;
@property(nonatomic, strong)NSString     * smallImages;




- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
