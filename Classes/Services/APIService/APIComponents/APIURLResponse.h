//
//  APIURLResponse.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/19.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APINetworkingConfiguration.h"

@interface APIURLResponse : NSObject

@property (nonatomic, assign, readonly) APIURLResponseStatus status;
@property (nonatomic, copy, readonly) id content;

- (instancetype)initWithResponseData:(NSData *)responseData status:(APIURLResponseStatus)status;
- (instancetype)initWithResponseData:(NSData *)responseData error:(NSError *)error;
- (instancetype)initWithData:(NSData *)data;

@end
