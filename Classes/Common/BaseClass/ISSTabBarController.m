//
//  ISSTabBarController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTabBarController.h"
#import "ISSHomeViewController.h"
#import "ISSMapViewController.h"
#import "ISSMessageViewController.h"
#import "ISSSystemViewController.h"

#define IMAGE_W 22
#define IMAGE_H 22
#define LABEL_W 60
#define LABEL_H 20

@interface ISSTabBarController ()<UITabBarControllerDelegate>
{
    NSArray       *titlesArray;
    NSArray       *normalImageArray;
    NSArray       *lightImageArray;
}
@end

@implementation ISSTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //[self.tabBar setHidden:YES];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    titlesArray = @[@"首页",@"地图",@"消息",@"系统"];
    normalImageArray = @[@"home",@"map",@"message",@"system"];
    lightImageArray = @[@"home-choice",@"map-choice",@"message-choice",@"system-choice"];
    
    //自定义tabBar
    //[self createCustomTabBarView];
    //关联viewController
    //[self createViewControllerToTabBarView];
    
    // add bj xjw，不采取自定义tabbar
    self.tabBarController.delegate = self;
    [self createTabbar];
}

- (UIImage *)getImage:(NSString *)imageName
{
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UITabBarItem *)getTabBarItem:(NSInteger)index
{
    return [[UITabBarItem alloc] initWithTitle:titlesArray[index]
                                         image:[self getImage:normalImageArray[index]]
                                 selectedImage:[self getImage:lightImageArray[index]]];
}

- (void)createTabbar
{
    self.tabBar.tintColor = ISSColorNavigationBar;
    //首页
    ISSHomeViewController * homeVC = [[ISSHomeViewController alloc] init];
    ISSNavigationController * homeNav = [[ISSNavigationController alloc] initWithRootViewController:homeVC];
    homeNav.tabBarItem = [self getTabBarItem:0];
    //地图
    ISSMapViewController * mapVC = [[ISSMapViewController alloc] init];
    ISSNavigationController * mapNav = [[ISSNavigationController alloc] initWithRootViewController:mapVC];
    mapNav.tabBarItem = [self getTabBarItem:1];
    //消息
    ISSMessageViewController * messageVC = [[ISSMessageViewController alloc] init];
    ISSNavigationController * messageNav = [[ISSNavigationController alloc] initWithRootViewController:messageVC];
    messageNav.tabBarItem = [self getTabBarItem:2];
    //系统
    ISSSystemViewController * systemVC = [[ISSSystemViewController alloc] init];
    ISSNavigationController * systemNav = [[ISSNavigationController alloc] initWithRootViewController:systemVC];
    systemNav.tabBarItem = [self getTabBarItem:3];
    
    self.viewControllers = @[homeNav,mapNav,messageNav,systemNav];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //[ISSGlobalVariable sharedInstance].tabBarIndex = self.selectedIndex;
    [self postControllerWithIndex:self.selectedIndex];
}

#pragma mark - 以前的
//自定义tab
- (void)createCustomTabBarView
{
    //背景
    self.backGroundIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kTabbarHeight, SCREEN_WIDTH, kTabbarHeight)];
    //    backGroundIV.image = [UIImage imageNamed:@"tab_backImage"];
    _backGroundIV.backgroundColor = ISSColorTabBar;
    _backGroundIV.userInteractionEnabled = YES;
    [self.view addSubview:_backGroundIV];
    
    // 标签
    for (int i=0; i<titlesArray.count; i++) {
        
        CGFloat itemButWidth = SCREEN_WIDTH/titlesArray.count;
        
        UIButton * itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        itemButton.tag = 10000+i;
        [itemButton addTarget:self action:@selector(clickTabBarAction:) forControlEvents:UIControlEventTouchUpInside];
        [_backGroundIV addSubview:itemButton];
        
        UIImageView *tabImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[normalImageArray objectAtIndex:i]] highlightedImage:[UIImage imageNamed:[lightImageArray objectAtIndex:i]]];
//        UIImageView *tabImageView = [[UIImageView alloc]initWithImage:[ISSUtilityMethod createImageWithColor:ISSColorWhite size:CGSizeMake(20, 20)] highlightedImage:[ISSUtilityMethod createImageWithColor:ISSColorRed size:CGSizeMake(20, 20)]];

        [itemButton addSubview:tabImageView];
        
        
        itemButton.frame = CGRectMake(i * itemButWidth, 0, itemButWidth, kTabbarHeight);
        tabImageView.frame = CGRectMake((itemButWidth-IMAGE_W)/2, 7, IMAGE_W, IMAGE_H);
        
        UILabel * itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, tabImageView.bottom, itemButWidth, LABEL_H)];
        itemLabel.text = [titlesArray objectAtIndex:i];
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.font = ISSFont10;
        [itemButton addSubview:itemLabel];
        
        if (i == 0) {
            tabImageView.highlighted = YES;
            itemLabel.textColor = ISSColorNavigationBar;
        }else{
            tabImageView.highlighted = NO;
            itemLabel.textColor = ISSColorWhite;
        }
        
    }
    
}

- (void)changeTabIndex:(NSInteger)index{
    
    UIButton * indexButton = (UIButton *)[_backGroundIV viewWithTag:10000+index];
    [self clickTabBarAction:indexButton];
    self.backGroundIV.hidden = NO;
}

- (void)clickTabBarAction:(id)sender
{
    UIButton * button = (UIButton *)sender;
    
    for (int j = 0; j<titlesArray.count; j++) {
        
        if (button.tag - 10000 == 1) {
            //记录定制前控制器
            [ISSGlobalVariable sharedInstance].tabBarIndex = self.selectedIndex;
        }
        //点击的tab变选中
        if (button.tag-10000 == j) {
            ((UIImageView *)button.subviews[0]).highlighted = YES;
            ((UILabel *)button.subviews[1]).textColor = ISSColorNavigationBar;
            
        }else{
            
            UIButton *normalBtn = [_backGroundIV viewWithTag:j+10000];
            ((UIImageView *)normalBtn.subviews[0]).highlighted = NO;
            ((UILabel *)normalBtn.subviews[1]).textColor = ISSColorDardGray9;
        }
    }
    
    self.selectedIndex = button.tag - 10000;
    [self postControllerWithIndex:self.selectedIndex];
}

//需要通知的控制器
- (void)postControllerWithIndex:(NSInteger)index
{
    if (index == 1)
    {
        [kDefaultCenter postNotificationName:kMapVCRefresh object:nil];
    }
    else if (index == 2)
    {
        [kDefaultCenter postNotificationName:kMessageVCRefresh object:nil];
    }
    
}



//关联viewController
- (void)createViewControllerToTabBarView
{
    //首页
    ISSHomeViewController * homeVC = [[ISSHomeViewController alloc] init];
    ISSNavigationController * homeNav = [[ISSNavigationController alloc] initWithRootViewController:homeVC];
    //地图
    ISSMapViewController * mapVC = [[ISSMapViewController alloc] init];
    ISSNavigationController * mapNav = [[ISSNavigationController alloc] initWithRootViewController:mapVC];
    //消息
    ISSMessageViewController * messageVC = [[ISSMessageViewController alloc] init];
    ISSNavigationController * messageNav = [[ISSNavigationController alloc] initWithRootViewController:messageVC];
    //系统
    ISSSystemViewController * systemVC = [[ISSSystemViewController alloc] init];
    ISSNavigationController * systemNav = [[ISSNavigationController alloc] initWithRootViewController:systemVC];
    
    self.viewControllers = @[homeNav,mapNav,messageNav,systemNav];
    [self changeTabIndex:0];
}

//推送通知处理
- (void)receiveNotification
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
