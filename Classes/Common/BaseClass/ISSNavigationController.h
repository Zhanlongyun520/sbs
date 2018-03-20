//
//  ISSNavigationController.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISSNavigationController : UINavigationController

@property (nonatomic, strong) NSMutableArray *viewControllerStach;

//底部分割线
@property (nonatomic, strong) UIView * bottomLine;


- (void)replaceCurrentControllerWithController:(UIViewController *)vc;


/**
 *  Description
 *
 *  @param viewController 要推出的controller
 *  @param animated       动画效果
 *  @param jumped         当前controller是否跳过不再返回
 */
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
               whetherJump:(BOOL)jumped;
@end
