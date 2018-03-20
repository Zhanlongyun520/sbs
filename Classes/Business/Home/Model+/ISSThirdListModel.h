//
//  ISSThirdListModel.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/27.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISSThirdListModel : NSObject

@property(nonatomic, strong)NSString     * thirdID;
@property(nonatomic, strong)NSString     * address;
@property(nonatomic, strong)NSString     * datetime;
@property(nonatomic, strong)NSString     * account;
@property(nonatomic, strong)NSString     * company;
@property(nonatomic, strong)NSString     * category;




- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
