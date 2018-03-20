//
//  ISSTrackPointAnnotation.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface ISSTrackPointAnnotation : MAPointAnnotation

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) id model;

@end
