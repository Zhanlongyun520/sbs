//
//  ISSColorDefine.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#ifndef ISSColorDefine_h
#define ISSColorDefine_h

//随机
#define ISSRandomColor  [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:(arc4random() % 256)/255.0]

//背景色
#define ISSColorViewBg               [ISSUtilityMethod colorWithHexColorString:@"#f5f5f5"]
#define ISSColorViewBg1              [ISSUtilityMethod colorWithHexColorString:@"#f9f9f9"]

#define ISSColorNavigationBar        [ISSUtilityMethod colorWithHexColorString:@"#3464dd"]
#define ISSColorTabBar               [UIColor whiteColor]

//k-line
#define ISSColorKLine                [ISSUtilityMethod colorWithHexColorString:@"#599fff"]

#define TableSeparatorColor [UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:0.3] // 线条颜色
#define IndicatorColorBlue [UIColor colorWithRed:9/255.0 green:40/255.0 blue:164/255.0 alpha:1.0]
#define IndicatorColorOrange [UIColor colorWithRed:246/255.0 green:56/255.0 blue:58/255.0 alpha:1.0]

//分割线
#define ISSColorSeparatorLine        [ISSUtilityMethod colorWithHexColorString:@"#eeeeee"]

#define ISSColorBlue                 [UIColor blueColor]
#define ISSColorBlack                [UIColor blackColor]
#define ISSColorWhite                [UIColor whiteColor]
#define ISSColorRed                  [UIColor redColor]

#define ISSColorTitle                [ISSUtilityMethod colorWithHexColorString:@"#212121"]


#define ISSColorDardGray2            [ISSUtilityMethod colorWithHexColorString:@"#222222"]
#define ISSColorDardGray6            [ISSUtilityMethod colorWithHexColorString:@"#666666"]
#define ISSColorDardGray9            [ISSUtilityMethod colorWithHexColorString:@"#999999"]
#define ISSColorDardGrayC            [ISSUtilityMethod colorWithHexColorString:@"#cccccc"]

//描述性文字（标题及介绍性文本）
#define ISSColorLightGray            [ISSUtilityMethod colorWithHexColorString:@"#bbbbbb"]
#define ISSColorAddImageButton       [ISSUtilityMethod colorWithHexColorString:@"#cad9ff"]


#endif /* ISSColorDefine_h */
