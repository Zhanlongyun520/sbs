//
//  ISSViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSViewController.h"
#import "AppDelegate.h"

@interface ISSViewController ()
{
    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer;
}

@property (nonatomic, strong)UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation ISSViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hiddenUIItem];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addScreenEdgePanGesture];
    self.view.backgroundColor = ISSColorViewBg;
    
    [self navSetUp];
    
    
    [[[UIApplication sharedApplication]keyWindow]addSubview:self.ballastCarView] ;

    
//    [self.view addSubview:self.ballastCarView];
//    self.ballastCarView.topSuperView;
}

- (void)removeScreenEdgePanGesture{
    [self.view removeGestureRecognizer:edgePanGestureRecognizer];
}

- (void)hiddenBackBarButtonItem{
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
}

#pragma mark - LoadingView

- (XTLoadingView *)loadingView
{
    if (nil == _loadingView) {
        
        _loadingView = [[XTLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,(kScreenHeight -64)/2-40, 60, 80)];
//        _loadingView.backgroundColor = ISSColorRed;
        
    }
    return _loadingView;
}

- (void)showLoadingView{
    [self.loadingView startAnimation];
    [self.view addSubview:_loadingView];

}

- (void)hiddenLoadingView{
    [self.loadingView stopAnimationWithLoadText:@"" withType:YES];
}

#pragma mark - Custom Fuction
- (void)hiddenUIItem
{
    if (_isPresentVC != YES) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.tabBarController.backGroundIV.hidden = NO;
        
        if (_isHiddenTabBar == YES) {
            appDelegate.tabBarController.backGroundIV.hidden = YES;
        }
    }
    
    self.navigationController.bottomLine.hidden = NO;
    if (_isHiddenNavLine == YES) {
        self.navigationController.bottomLine.hidden = YES;
    }
    
    if (_isWhiteNavItem == YES) {
        self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:ISSFont18,
                                                                        NSForegroundColorAttributeName:ISSColorWhite};
    }
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = ISSColorNavigationBar;
    [self.navigationController.navigationBar lt_setBackgroundColor:[ISSColorNavigationBar colorWithAlphaComponent:0]];
    
    if (_ishiddenNav == YES) {
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
}

- (void)navSetUp
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 19, 19);
    [leftBtn setImage:[UIImage imageNamed:@"bigarrow"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backBarButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:ISSFont18,
                                                                    NSForegroundColorAttributeName:ISSColorWhite};
}

#pragma mark - Button Action

- (void)backBarButton:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addScreenEdgePanGesture{
    
    edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGesture:)];
    //设置从什么边界滑入
    edgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePanGestureRecognizer];
}

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer{
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        
        CGFloat progress = [recognizer translationInView:self.view].x / self.view.bounds.size.width;
        progress = MIN(1.0, MAX(0.0, progress));//把这个百分比限制在0~1之间
        
        //当手势刚刚开始，我们创建一个 UIPercentDrivenInteractiveTransition 对象
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self.navigationController popViewControllerAnimated:YES];
        }else if (recognizer.state == UIGestureRecognizerStateChanged){
            //当手慢慢划入时，我们把总体手势划入的进度告诉 UIPercentDrivenInteractiveTransition 对象。
            [self.percentDrivenTransition updateInteractiveTransition:progress];
        }else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded){
            //当手势结束，我们根据用户的手势进度来判断过渡是应该完成还是取消并相应的调用 finishInteractiveTransition 或者 cancelInteractiveTransition 方法.
            if (progress > 0.5) {
                [self.percentDrivenTransition finishInteractiveTransition];
            }else{
                [self.percentDrivenTransition cancelInteractiveTransition];
            }
        }
    }
}

- (ISSBallastCarView *)ballastCarView
{
    if (_ballastCarView == nil) {
        _ballastCarView = [[ISSBallastCarView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        _ballastCarView.hidden = YES;
    }
    return _ballastCarView;
}

- (ISSNavigationController *)navigationController{
    return (ISSNavigationController *)super.navigationController;
}

- (void)dealloc{
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}



@end
