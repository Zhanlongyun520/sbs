//
//  NSObject+UVObjects.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/22.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "NSObject+UVObjects.h"

@implementation NSObject (UVObjects)

- (MBProgressHUD*)progress:(UIView *)view_ message:(NSString *)mess_
{
    if(!view_)
    {
        return nil;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view_ animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = mess_;
    
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

@end
