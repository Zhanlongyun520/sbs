//
//  ISSCarListTableViewCell.h
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSCarListModel.h"

@interface ISSCarListTableViewCell : UITableViewCell

@property(nonatomic , strong)UIButton * mapButton;
@property(nonatomic , strong)UIButton * photoButton;
@property(nonatomic , strong)UIButton * historyButton;

- (void)conFigDataCarListModel:(ISSCarListModel *)listModel;

@property (nonatomic, copy) void (^ btnAction)(ISSCarListTableViewCell *, UIButton *btn);

@end
