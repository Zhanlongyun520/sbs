//
//  ISSAboutUsViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSAboutUsViewController.h"

@interface ISSAboutUsViewController ()

@end

@implementation ISSAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHiddenTabBar = YES;
    self.title = @"关于我们";
    [self initView];
}


- (void)initView
{
    UIImageView * imageView = [[UIImageView alloc]initForAutoLayout];
    imageView.image = [UIImage imageNamed:@"launch"];
    [self.view addSubview:imageView];
    [self.view addConstraint:[imageView constraintCenterXInContainer]];
    [self.view addConstraints:[imageView constraintsTopInContainer:90]];

    UILabel * nameLabel = [[UILabel alloc]initForAutoLayout];
    nameLabel.text = @"光谷中心城绿色智慧工地";
    nameLabel.font = ISSFont18;
    nameLabel.textColor = ISSColorTitle;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameLabel];
    [self.view addConstraint:[nameLabel constraintCenterXInContainer]];
    [self.view addConstraints:[nameLabel constraintsTop:16 FromView:imageView]];
    
    UILabel * versionLabel = [[UILabel alloc]initForAutoLayout];
    versionLabel.text = [NSString stringWithFormat:@"Version %@",BuildeVersion];
    versionLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    versionLabel.textColor = ISSColorDardGray2;
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:versionLabel];
    [self.view addConstraint:[versionLabel constraintCenterXInContainer]];
    [self.view addConstraints:[versionLabel constraintsTop:12 FromView:nameLabel]];

    UILabel * copyrightLabel = [[UILabel alloc]initForAutoLayout];
    copyrightLabel.text = @"© 2017 光谷中心城 All Rights Reserved.";
    copyrightLabel.font = ISSFont12;
    copyrightLabel.textColor = ISSColorDardGray9;
    copyrightLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:copyrightLabel];
    [self.view addConstraint:[copyrightLabel constraintCenterXInContainer]];
    [self.view addConstraints:[copyrightLabel constraintsBottomInContainer:24]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
