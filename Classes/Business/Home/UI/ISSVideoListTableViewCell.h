//
//  ISSVideoListTableViewCell.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/20.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSVideoModel.h"

@interface ISSVideoListTableViewCell : UITableViewCell

@property(nonatomic , strong)UIButton * mapButton;
@property(nonatomic , strong)UIButton * realTimeButton;
@property(nonatomic , strong)UIButton * historyButton;
@property(nonatomic , strong)UIButton * ssButton;

- (void)conFigDataVideoModel:(ISSVideoModel *)videoModel;


@end

