//
//  ISSReportRInputCell.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseTableViewCell.h"
#import "SZTextView.h"

@interface ISSReportRInputCell : ISSBaseTableViewCell

@property (nonatomic, strong) SZTextView *textView;
@property (nonatomic, strong) NSMutableArray *photoArray;

@property (nonatomic, copy) void (^addPhotoBlock) ();
@property (nonatomic, copy) void (^removePhotoBlock) (NSInteger index);

@end
