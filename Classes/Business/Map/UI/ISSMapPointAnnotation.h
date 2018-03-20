//
//  ISSMapPointAnnotation.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2018/1/2.
//  Copyright © 2018年 iSoftStone. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "ISSVideoModel.h"

@interface ISSMapPointAnnotation : MAPointAnnotation

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) ISSVideoModel *model;

@end
