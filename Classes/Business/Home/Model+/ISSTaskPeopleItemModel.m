//
//  ISSTaskPeopleItemModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTaskPeopleItemModel.h"
#import "ISSTaskPeopleModel.h"
#import "PinYin4Objc.h"

@implementation ISSTaskPeopleItemModel

- (instancetype)init {
    if (self = [super init]) {
        _dataArray = @[].mutableCopy;
    }
    return self;
}

+ (NSMutableArray *)handleData:(NSArray *)orginList {
    NSMutableArray *itemArray = [NSMutableArray array];
    
    HanyuPinyinOutputFormat *outputFormat = [[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    
    for (ISSTaskPeopleModel *dic in orginList) {
        NSString *city = dic.name;
        if (city && city.length > 0) {
            NSString *outputPinyin = [PinyinHelper toHanyuPinyinStringWithNSString:city withHanyuPinyinOutputFormat:outputFormat withNSString:@" "];
            outputPinyin = [outputPinyin substringToIndex:1].uppercaseString;
            ISSTaskPeopleItemModel *model;
            for (ISSTaskPeopleItemModel *item in itemArray) {
                if ([item.firstLetter isEqualToString:outputPinyin]) {
                    model = item;
                    break;
                }
            }
            if (!model) {
                model = [[ISSTaskPeopleItemModel alloc] init];
                model.firstLetter = outputPinyin;
                [itemArray addObject:model];
            }
            [model.dataArray addObject:dic];
        }
    }
    
    NSArray *array = [itemArray sortedArrayUsingComparator:^NSComparisonResult(ISSTaskPeopleItemModel *p1, ISSTaskPeopleItemModel *p2){
        return [p1.firstLetter compare:p2.firstLetter];
    }];
    
    return [NSMutableArray arrayWithArray:array];
}

@end
