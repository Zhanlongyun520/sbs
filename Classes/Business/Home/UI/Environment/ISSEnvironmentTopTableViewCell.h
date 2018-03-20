//
//  ISSEnvironmentTopTableViewCell.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSTitleButton.h"

@interface ISSEnvironmentTopTableViewCell : UITableViewCell

@property(nonatomic , strong)ISSTitleButton * timeButton;
@property(nonatomic , strong)ISSTitleButton * choiceButton;

@property (nonatomic, copy) void (^ btnAction)(ISSEnvironmentTopTableViewCell *innerCell, UIButton *btn, id obj);

- (NSString *)formatterBtnTitle:(NSDate *)date;

@end
