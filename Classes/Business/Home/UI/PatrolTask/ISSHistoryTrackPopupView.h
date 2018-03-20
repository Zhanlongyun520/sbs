//
//  ISSHistoryTrackPopupView.h
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/17.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSCarTrackModel.h"

@interface ISSHistoryTrackPopupView : UIView

@property (nonatomic, strong) ISSCarTrackModel *model;

@property (nonatomic, copy) void (^dissmissBlock) (void);
@property (nonatomic, copy) void (^showDetailBlock) (ISSCarTrackModel *model);

@end
