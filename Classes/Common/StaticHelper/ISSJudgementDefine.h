//
//  ISSJudgementDefine.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/19.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#ifndef ISSJudgementDefine_h
#define ISSJudgementDefine_h

#define TestAPI 0

#define BuildeVersion @"1.1.0"



#define deviceIs6P      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define SystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)
#define IOS8_LATER SystemVersionGreaterOrEqualThan(8.0)


#define perfix ((int)[UIScreen mainScreen].scale == 1 ? @"":((int)[UIScreen mainScreen].scale == 2?@"@2x":@"@3x"))
#define resourceImagePath(imageString) [UIImage imageNamed:imageString]

#endif /* ISSJudgementDefine_h */
