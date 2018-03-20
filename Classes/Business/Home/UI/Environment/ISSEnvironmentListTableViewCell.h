//
//  ISSEnvironmentListTableViewCell.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/20.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSEnvironmentListModel.h"

@interface ISSEnvironmentListTableViewCell : UITableViewCell

@property(nonatomic , strong)UIButton * mapButton;
@property(nonatomic , strong)UIButton * realTimeButton;
@property(nonatomic , strong)UIButton * historyButton;

- (void)conFigDataEnvironmentListModel:(ISSEnvironmentListModel *)environmentListModel;


@end
