//
//  ISSCarTrackAnnotation.h
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/18.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "ISSCarTrackModel.h"

@interface ISSCarTrackAnnotation : MAPointAnnotation

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) ISSCarTrackModel *model;

@end
