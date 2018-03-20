//
//  ISSThirdAddReportTableViewCell.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/3.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTTextView.h"

typedef void (^ThirdAddReportCellBlock)(CGFloat height,NSMutableArray *array);

@interface ISSThirdAddReportTableViewCell : UITableViewCell

@property(nonatomic , strong) UIImageView     * viewBG;

@property(nonatomic , strong) XTTextView      * textView;

@property(nonatomic , strong) NSMutableArray        * imagesArray;
@property(nonatomic , strong) UIViewController        * controller;

@property(nonatomic , copy)   ThirdAddReportCellBlock            thirdAddReportCellBlock;



@end
