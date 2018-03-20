//
//  ISSESpaceTableViewCell.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/17.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSTitleButton.h"
@interface ISSESpaceTableViewCell : UITableViewCell

@property(nonatomic , strong)ISSTitleButton * choiceButton;

- (void)conFigDataTitle:(NSString *)title ButtonHidden:(BOOL)isHidden ButtonTitle:(NSString *)buttonTitle;

@end
