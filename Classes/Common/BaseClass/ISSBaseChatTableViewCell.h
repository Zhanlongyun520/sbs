//
//  ISSBaseChatTableViewCell.h
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/13.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSTitleButton.h"
#import "Masonry.h"

#import "SmartBuildingSite-Bridging-Header.h"
@interface IntAxisValueFormatter : NSObject <IChartValueFormatter>
@end

@interface FloatAxisValueFormatter : NSObject <IChartValueFormatter>
@end

@interface ISSBaseChatTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *choiceButton;
@property (nonatomic, strong) UIButton *timeButton;

@property (nonatomic, copy) void (^ btnAction)(ISSBaseChatTableViewCell *innerCell, UIButton *btn, id obj);

- (void)fillChatDataSource:(id)data;

- (NSString *)formatterBtnTitle:(NSDate *)date type:(NSInteger)type;

@end
