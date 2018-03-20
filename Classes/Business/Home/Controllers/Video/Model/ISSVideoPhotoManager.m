//
//  ISSVideoPhotoManager.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/26.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSVideoPhotoManager.h"

@implementation ISSVideoPhotoManager

+ (void)createPhoto:(UVStreamPlayer *)streamPlayer code:(NSString *)code {
    if(!streamPlayer.isPlaying) return;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *dateString = [formatter stringFromDate:now];
    
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    NSString *docPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"image/%@", code]];
    if (![fileManager fileExistsAtPath:docPath]) {
        [fileManager createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpeg", dateString]];
    
    NSLog(@"image path: %@", filePath);
    
    if (![fileManager fileExistsAtPath:filePath]) {
        
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        
    }
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSLog(@"%@", url);
    [streamPlayer snatch:url];
}

+ (NSArray *)getPhotos:(NSString *)code {
    NSMutableArray *photoList = @[].mutableCopy;
    
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    NSString *docPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"image/%@", code]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:docPath]) {
        NSArray *tempArray = [fileManager contentsOfDirectoryAtPath:docPath error:nil];
        for (NSString *fileName in tempArray) {
            BOOL flag = YES;
            NSString *fullPath = [docPath stringByAppendingPathComponent:fileName];
            if ([fileManager fileExistsAtPath:fullPath isDirectory:&flag]) {
                if (!flag) {
                    NSURL *url = [NSURL fileURLWithPath:fullPath];
                    [photoList addObject:url];
                }
            }
        }
    }
    
    return photoList;
}

@end
