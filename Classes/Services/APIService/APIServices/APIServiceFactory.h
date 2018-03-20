//
//  APIServiceFactory.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/19.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIBaseService.h"

@interface APIServiceFactory : NSObject

+ (instancetype)sharedInstance;

- (APIBaseService <APIBaseServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier;

@end
