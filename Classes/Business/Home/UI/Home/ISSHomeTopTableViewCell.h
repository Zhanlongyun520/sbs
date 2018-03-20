//
//  ISSHomeTopTableViewCell.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/13.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSHomeModel.h"

@interface ISSHomeTopTableViewCell : UIView

@property(nonatomic , strong)UIButton * messageButton;
@property(nonatomic , strong)UILabel  * messageBadge;
@property(nonatomic , strong)UIButton * pendingButton;
@property(nonatomic , strong)UILabel  * pendingBadge;
@property(nonatomic , strong)UIButton * videoButton;
@property(nonatomic , strong)UILabel  * videoBadge;
@property(nonatomic , strong)UIButton * environmentButton;
@property(nonatomic , strong)UILabel  * environmentBadge;

- (void)conFigDataHomeModel:(ISSHomeModel *)homeModel;


@end
