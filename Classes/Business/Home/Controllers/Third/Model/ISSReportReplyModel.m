//
//  ISSReportReplyModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/22.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportReplyModel.h"

@implementation ISSReportReplyModel

- (void)setFiles:(NSString *)files {
    _files = files;
    
    if (files.length > 0) {
        NSData *jsonData = [files dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        _filesArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                      options:NSJSONReadingMutableContainers
                                                        error:&err];
        if (err) {
            NSLog(@"%@", err);
        }
    }
}

- (void)setSmallFiles:(NSString *)smallFiles {
    _smallFiles = smallFiles;
    
    if (smallFiles.length > 0) {
        NSData *jsonData = [smallFiles dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        _smallFilesArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                      options:NSJSONReadingMutableContainers
                                                        error:&err];
        if (err) {
            NSLog(@"%@", err);
        }
    }
}

- (void)setStatus:(NSInteger)status {
    _status = status;
    
    _statusDes = nil;
    switch (status) {
        case 1:
            _statusDes = @"已提交";
            break;
            
        case 2:
            _statusDes = @"待处理";
            break;
            
        case 3:
            _statusDes = @"待回访";
            break;
            
        case 4:
            _statusDes = @"已退回";
            break;
            
        case 5:
            _statusDes = @"已验收";
            break;
            
        default:
            break;
    }
}

- (UIColor *)getStatusColor {
    UIColor *color = [UIColor lightGrayColor];
    
    switch (_status) {
        case 1:
            color = [UIColor colorWithRed:0.50 green:0.64 blue:0.98 alpha:1.00];
            break;
            
        case 2:
            color = [UIColor colorWithRed:0.50 green:0.64 blue:0.98 alpha:1.00];
            break;
            
        case 3:
            color = [UIColor colorWithRed:0.92 green:0.60 blue:0.46 alpha:1.00];
            break;
            
        case 4:
            color = [UIColor colorWithRed:0.99 green:0.54 blue:0.55 alpha:1.00];
            break;
            
        case 5:
            color = [UIColor colorWithRed:0.52 green:0.84 blue:0.78 alpha:1.00];
            break;
            
        default:
            break;
    }
    return color;
}

@end
