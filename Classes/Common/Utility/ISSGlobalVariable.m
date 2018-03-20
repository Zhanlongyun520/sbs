//
//  ISSGlobalVariable.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSGlobalVariable.h"

@implementation ISSGlobalVariable

static ISSGlobalVariable *s = nil;

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s = [[ISSGlobalVariable alloc] init];
        
#if TestAPI
        [[NSUserDefaults standardUserDefaults] setObject:@"cbd" forKey:@"netstatus"];
#else
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"netstatus"];
#endif
        
    });
    
    return s;
}

+ (BOOL)serverBaseUrlIsTest{
    
    NSString *netstatus = [[NSUserDefaults standardUserDefaults] objectForKey:@"netstatus"];
    
    return [netstatus isEqualToString:@"cbd"];
}

//存请求
+ (NSString *)recordRequestUrlFilePath{
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/requestInfo.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    //    NSLog(@"路径：%@",filePath);
    return filePath;
}

@end
