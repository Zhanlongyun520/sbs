//
//  ISSENearestModel.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/17.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISSENearestModel : NSObject

@property(nonatomic, strong)NSString     * pushTime;
@property(nonatomic, strong)NSString     * airHumidity; //湿度
@property(nonatomic, strong)NSString     * windDirection; //风向

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
