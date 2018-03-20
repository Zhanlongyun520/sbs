//
//  ISSTrackPopupTouchView.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISSTrackPopupTouchView : UIView

@property (nonatomic, copy) void (^touchBlock) (void);

@end
