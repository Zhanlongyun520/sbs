
//
//  ISSFreedBackViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSFreedBackViewController.h"
#import "XTTextView.h"

@interface ISSFreedBackViewController ()<UITextViewDelegate>

@property(nonatomic,strong) XTTextView          * feedbackTF;
@property(nonatomic,strong) UIButton            * sureBtn;


@end

@implementation ISSFreedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHiddenTabBar = YES;
    self.title = @"意见反馈";
    
    [self initView];
}

- (void)initView
{
    UIImageView * bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 220)];
    bgView.backgroundColor = ISSColorWhite;
    [self.view addSubview:bgView];
    
    _feedbackTF = [[XTTextView alloc]init];
    _feedbackTF.frame = CGRectMake(16, 16, kScreenWidth - 32, 220 - 32);
    _feedbackTF.font = ISSFont14;
    _feedbackTF.placeholder = @"我们需要您的宝贵意见";
    _feedbackTF.placeholderTextColor = ISSColorDardGrayC;
    _feedbackTF.delegate = self;
    _feedbackTF.layer.borderColor = [ISSColorDardGrayC CGColor];
    _feedbackTF.layer.borderWidth = 0.5f;
    _feedbackTF.layer.masksToBounds = YES;
    [self.view addSubview:_feedbackTF];
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.frame = CGRectMake(16, 236, kScreenWidth - 32, 48);
    [_sureBtn setTitle:@"提交" forState:UIControlStateNormal];
    _sureBtn.layer.cornerRadius = 5;
    [_sureBtn setBackgroundColor:ISSColorNavigationBar];
    [_sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sureBtn];
}


- (void)sureBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    ALERT(@"提交成功");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
