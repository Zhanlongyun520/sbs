//
//  ISSTrackPopupTouchView.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTrackPopupTouchView.h"

@implementation ISSTrackPopupTouchView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    if (self.touchBlock) {
        self.touchBlock();
    }
}

@end
