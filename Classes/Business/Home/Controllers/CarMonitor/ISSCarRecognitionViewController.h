//
//  ISSCarRecognitionViewController.h
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSViewController.h"
#import "ISSunRecListModel.h"

@interface ISSCarRecognitionViewController : ISSViewController

@property (nonatomic, strong) ISSunRecListModel *model;

@property (nonatomic, copy) void (^ btnAction)(NSInteger tag);

@end
