//
//  ISSConstKey.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#ifndef ISSConstKey_h
#define ISSConstKey_h

//适配
#define kScreenWidth                [UIScreen mainScreen].bounds.size.width
#define kScreenHeight               [UIScreen mainScreen].bounds.size.height
#define kTabbarHeight               49.0f
#define kStatusBarHeight            20.0f
#define kNavigationBarHeight        44.0f
#define kNavBarAndStatBarHeight     64.0f
#define kAllBarHeight               113.0f
#define kDefaultCenter              [NSNotificationCenter defaultCenter]

#define kR35 CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 480))
#define kR40 CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568))
#define kR47 CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 667))
#define kR55 CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 736))
#define kR58 CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812))

#define ALD(x)      (x * kScreenWidth/375.0)
#define TopDem(x)   ([UIScreen mainScreen].scale >= 3 ? x*1.5 : x)

#define kNoLogin                             @"noLogin"                    //token失效
#define ALERT(a) [[TKAlertCenter defaultCenter] postAlertWithMessage:a];

//通知
#define kMessageVCRefresh                    @"MessageVCRefresh"
#define kMapVCRefresh                        @"MapVCRefresh"
#define kLoginSuccess                        @"kLoginSuccess"
#define kLoginOut                            @"kLoginOut"


#define KVideoInformation                    @"KVideoInformation"          //登录返回视屏字典的key值


//数据格式转化
#define NumberToString(a)          [NSString stringWithFormat:@"%@", @(a)]
#define ToString(x)  [x isKindOfClass:[NSString class]] ? x : ([x isKindOfClass:[NSNumber class]] ? [NSString stringWithFormat:@"%@", x] : nil)
#define ToNSNumber(x) [x isKindOfClass:[NSNumber class]] ? x : ([x isKindOfClass:[NSString class]] ? @([x doubleValue]) : @(INT32_MAX))

//日志打印宏
//#ifdef DEBUG
//
//#define NSLog(format, ...) do {                                                 \
//fprintf(stderr, "\n<-------\n");                                              \
//fprintf(stderr, "<%s : %d> %s\n",                                           \
//[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
//__LINE__, __func__);                                                        \
//(NSLog)((format), ##__VA_ARGS__);                                           \
//fprintf(stderr, "------->\n");                                              \
//} while (0)
//
//#else
//
//#define NSLog(format, ...)
//
//#endif

#endif /* ISSConstKey_h */
