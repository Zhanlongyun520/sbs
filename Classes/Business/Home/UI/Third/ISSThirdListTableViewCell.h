//
//  ISSThirdListTableViewCell.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/31.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSThirdListModel.h"

@interface ISSThirdListTableViewCell : UITableViewCell

@property(nonatomic , strong)UIButton * detailButton;
@property(nonatomic , strong)UIButton * replyButton;
@property(nonatomic , strong)UIButton * visitButton;

- (void)conFigDataThirdListModel:(ISSThirdListModel *)thirdListModel;

@end
