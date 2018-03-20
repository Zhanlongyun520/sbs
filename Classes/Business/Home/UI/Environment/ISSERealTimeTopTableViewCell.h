//
//  ISSERealTimeTopTableViewCell.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/17.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSEnvironmentListModel.h"

@interface ISSERealTimeTopTableViewCell : UITableViewCell

- (void)conFigDataEnvironmentModel:(ISSEnvironmentListModel *)environmentListModel isComeFromHistory:(BOOL)isFromHistory;


@end
