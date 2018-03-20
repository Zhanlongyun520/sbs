//
//  ISSVideoPhotoManager.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/26.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"
#import "UVStreamPlayer.h"

@interface ISSVideoPhotoManager : ISSBaseModel

+ (void)createPhoto:(UVStreamPlayer *)streamPlayer code:(NSString *)code;
+ (NSArray *)getPhotos:(NSString *)code;

@end
