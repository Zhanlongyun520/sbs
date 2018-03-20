//
//  ISSThirdAddTableViewCell.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/3.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISSThirdAddTableViewCell : UITableViewCell

@property(nonatomic,strong)UITextField          * textField;
@property(nonatomic,strong)UILabel              * textRightLabel;

- (void)conFigDataTitle:(NSString *)titleStr ISAddImage:(BOOL)isAddImage HiddenText:(BOOL)isText;

@end
