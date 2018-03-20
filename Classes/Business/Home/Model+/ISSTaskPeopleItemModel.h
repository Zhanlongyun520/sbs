//
//  ISSTaskPeopleItemModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISSTaskPeopleItemModel : NSObject

@property (nonatomic, copy) NSString *firstLetter;
@property (nonatomic, strong) NSMutableArray *dataArray;

+ (NSMutableArray *)handleData:(NSArray *)orginList;

@end
