//
//  ISSViewController.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSBallastCarView.h"
#import "XTLoadingView.h"
#import "UIView+Toast.h"


@interface ISSViewController : UIViewController

/** 隐藏TabBar */
@property(nonatomic,assign)BOOL         isHiddenTabBar;
/** 隐藏NavLine */
@property(nonatomic,assign)BOOL         isHiddenNavLine;
/** 显示白色item */
@property(nonatomic,assign)BOOL         isWhiteNavItem;
/** 隐藏Navigation */
@property(nonatomic,assign)BOOL         ishiddenNav;
/** 模态起来的页面 */
@property(nonatomic,assign)BOOL         isPresentVC;


@property (nonatomic, strong, readonly) ISSNavigationController * navigationController;
@property (nonatomic, strong ) ISSBallastCarView        * ballastCarView;
@property (nonatomic, strong ) XTLoadingView            * loadingView;


/** 隐藏导航栏左侧返回按钮 */
- (void)hiddenBackBarButtonItem;

/** 移除侧滑返回手势 */
- (void)removeScreenEdgePanGesture;

/** 显示LoadingView */
- (void)showLoadingView;

/** 隐藏LoadingView */
- (void)hiddenLoadingView;


- (void)backBarButton:(UIButton *)btn;

@end
