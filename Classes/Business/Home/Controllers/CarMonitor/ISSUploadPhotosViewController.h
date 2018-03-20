//
//  ISSUploadPhotosViewController.h
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSViewController.h"

@interface ISSUploadPhotosViewController : ISSViewController

@property (nonatomic, strong) NSString *licence;

@property (nonatomic, copy) void (^ refreshAction)(void);

@end
