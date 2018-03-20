//
//  ISSGlobalVariable.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISSGlobalVariable : NSObject

@property (nonatomic, assign) NSInteger tabBarIndex;
@property (nonatomic, assign) BOOL  isJsonRequest;
@property (nonatomic, assign) BOOL  isMultipartContent;


+ (instancetype)sharedInstance;

+ (BOOL)serverBaseUrlIsTest;

+ (NSString *)recordRequestUrlFilePath;

@end
