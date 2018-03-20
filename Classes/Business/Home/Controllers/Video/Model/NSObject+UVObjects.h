//
//  NSObject+UVObjects.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/22.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface NSObject (UVObjects)

-(MBProgressHUD*)progress:(UIView*)view_ message:(NSString*)mess;

@end
