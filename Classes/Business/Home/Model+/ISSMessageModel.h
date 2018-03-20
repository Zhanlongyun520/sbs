//
//  ISSMessageModel.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/13.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"

@interface ISSMessageModel : ISSBaseModel

@property(nonatomic, strong)NSString     * infoId;
@property(nonatomic, strong)NSString     * title;
@property(nonatomic, strong)NSString     * content;
@property(nonatomic, strong)NSString     * updateTime;
@property(nonatomic, strong)NSString     * status;
@property(nonatomic, strong)NSString     * searchCode;
@property(nonatomic, strong)NSString     * unRead;
@property(nonatomic, strong)NSString     * infoTypeParentCode;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
