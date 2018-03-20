//
//  ISSThirdDetailModel.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/12/4.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISSThirdDetailModel : NSObject


@property(nonatomic, strong)NSString     * address;
@property(nonatomic, strong)NSString     * company;
@property(nonatomic, strong)NSString     * thirdID;



@property(nonatomic, strong)NSString     * constructionCompany;
@property(nonatomic, strong)NSString     * developmentCompany;
@property(nonatomic, strong)NSString     * supervisionCompany;
@property(nonatomic, strong)NSString     * category;

@property(nonatomic, strong)NSString     * date;
@property(nonatomic, strong)NSString     * status;

@property(nonatomic, strong)NSString     * needVisit;
@property(nonatomic, strong)NSString     * visitDate;
@property(nonatomic, strong)NSMutableArray     * reportsArray;


- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
