//
//  ISSCheckListViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/30.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSCheckListViewController.h"
//#import "APICheckListManager.h"

@interface ISSCheckListViewController ()
//<APIManagerCallBackDelegate>

//@property(nonatomic ,strong) APICheckListManager        *checkListManager;

@end

@implementation ISSCheckListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.checkListManager loadData];
    // Do any additional setup after loading the view.
}

//#pragma mark - APIManagerCallBackDelegate
//- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
//{
//    NSLog(@"%@",manager.errorMessage);
//    if([manager isKindOfClass:[APICheckListManager class]])
//    {
//        //        NSDictionary *dataDic = [manager fetchDataWithReformer:[[ISSVideoListReformer alloc]init]];
//        //        NSLog(@"%@",dataDic);
//    }
//}
//
//- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
//{
//    NSLog(@"%@",manager.errorMessage);
//    ALERT(manager.errorMessage);
//}

//- (APICheckListManager *)checkListManager
//{
//    if (nil == _checkListManager) {
//        _checkListManager = [[APICheckListManager alloc] init];
//        _checkListManager.delegate = self;
//    }
//    return _checkListManager;
//}

@end
