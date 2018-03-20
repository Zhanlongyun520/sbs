//
//  APIURLResponse.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/19.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIURLResponse.h"

@interface APIURLResponse ()

@property (nonatomic, assign, readwrite) APIURLResponseStatus status;
@property (nonatomic, copy, readwrite) id content;

@end

@implementation APIURLResponse

#pragma mark - life cycle

- (instancetype)initWithResponseData:(NSData *)responseData status:(APIURLResponseStatus)status
{
    self = [super init];
    if (self) {
        self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        self.status = status;
    }
    return self;
}

- (instancetype)initWithResponseData:(NSData *)responseData error:(NSError *)error
{
    self = [super init];
    if (self) {
        self.status = [self responseStatusWithError:error];
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        } else {
            self.content = nil;
        }
    }
    return self;
}

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        self.status = [self responseStatusWithError:nil];
        self.content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    }
    return self;
}

#pragma mark - private methods
- (APIURLResponseStatus)responseStatusWithError:(NSError *)error
{
    if (error) {
        APIURLResponseStatus result = APIURLResponseStatusErrorNoNetwork;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = APIURLResponseStatusErrorNoNetwork;
        }
        return result;
    } else {
        return APIURLResponseStatusSuccess;
    }
}


@end
