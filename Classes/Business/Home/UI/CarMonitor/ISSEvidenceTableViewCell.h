//
//  ISSEvidenceTableViewCell.h
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseTableViewCell.h"
#import "ISSEvidencePhotoModel.h"

@interface ISSEvidenceTableViewCell : ISSBaseTableViewCell

- (void)fillDataSource:(ISSEvidencePhotoModel *)model;

@end
