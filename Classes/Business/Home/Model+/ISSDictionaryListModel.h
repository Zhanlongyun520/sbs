//
//  ISSDictionaryListModel.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/29.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISSDictionaryListModel : NSObject

@property(nonatomic, strong)NSString     * code;
@property(nonatomic, strong)NSString     * content;
@property(nonatomic, strong)NSString     * datetime;
@property(nonatomic, strong)NSString     * dictionaryID;
@property(nonatomic, strong)NSString     * value;




- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
