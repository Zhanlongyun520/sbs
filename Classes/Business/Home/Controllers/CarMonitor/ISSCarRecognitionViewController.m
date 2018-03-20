//
//  ISSCarRecognitionViewController.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSCarRecognitionViewController.h"
#import "STPopup.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@implementation ISSCarRecognitionViewController

- (instancetype)init {
    if (self = [super init]) {
       
        self.contentSizeInPopup = CGSizeMake(300, 350);
        self.landscapeContentSizeInPopup = CGSizeMake(300, 300);
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.popupController.containerView.layer.cornerRadius = 8;
    
    [self.popupController.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                                               initWithTarget:self
                                                               action:@selector(bgViewDidTap)]];
    
    NSArray *imgList = [self.model.imgList componentsSeparatedByString:@","];
    
    UIImageView *carImgv = [[UIImageView alloc] init];
    carImgv.clipsToBounds = YES;
    carImgv.contentMode = UIViewContentModeScaleToFill;
    [carImgv sd_setImageWithURL:[NSURL URLWithString:imgList.firstObject]
               placeholderImage:[UIImage imageNamed:@"car_placeholder"]];
    [self.view addSubview:carImgv];
    
    UIButton *isNoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [isNoBtn setBackgroundImage:[UIImage imageNamed:@"car_truck_no"] forState:UIControlStateNormal];
    [isNoBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    isNoBtn.tag = 0;
    [self.popupController.backgroundView addSubview:isNoBtn];

    UIButton *isRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [isRightBtn setBackgroundImage:[UIImage imageNamed:@"car_truck_yes"] forState:UIControlStateNormal];
    [isRightBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    isRightBtn.tag = 1;
    [self.popupController.backgroundView addSubview:isRightBtn];

    UIButton *unrecognizedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [unrecognizedBtn setBackgroundImage:[UIImage imageNamed:@"car_unrecognized"] forState:UIControlStateNormal];
    [unrecognizedBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    unrecognizedBtn.tag = 2;
    [self.popupController.backgroundView addSubview:unrecognizedBtn];
    
    UILabel *licenceLbl = [[UILabel alloc] init];
    licenceLbl.text = self.model.licence;
    [self.view addSubview:licenceLbl];
    
    UIButton *checkNoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    checkNoButton.tintColor = [UIColor colorWithRed:0.98 green:0.27 blue:0.29 alpha:1.00];
    checkNoButton.layer.borderColor = checkNoButton.tintColor.CGColor;
    checkNoButton.layer.borderWidth = 1;
    checkNoButton.layer.cornerRadius = 5;
    checkNoButton.titleLabel.font = [UIFont systemFontOfSize:13];
    checkNoButton.tag = 2;
    [checkNoButton setTitle:@"车牌报错" forState:UIControlStateNormal];
    [checkNoButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkNoButton];
    [checkNoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(licenceLbl.mas_right).offset(10);
        make.centerY.equalTo(licenceLbl);
        make.height.equalTo(@26);
        make.width.equalTo(@65);
    }];
    
    NSArray *infos = @[@{@"img" : @"car_location",
                         @"title" : self.model.addr ?: @""},
                       @{@"img" : @"car_time",
                         @"title" : self.model.dateTime ?: @""},
                       @{@"img" : @"car_speed",
                         @"title" : self.model.speed ?: @""}];
    
    [infos enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *img = dict[@"img"];
        NSString *title = dict[@"title"];
        
        if (idx==2) {
            title = [title stringByAppendingString:@" km/h"];
        }
        
        UIImageView *logo = [[UIImageView alloc] init];
        logo.image = [UIImage imageNamed:img];
        logo.contentMode = UIViewContentModeCenter;
        [self.view addSubview:logo];
        
        UILabel *lbl = [[UILabel alloc] init];
        lbl.text = title;
        lbl.textColor = [UIColor darkGrayColor];
        lbl.font = [UIFont systemFontOfSize:12.0];
        [self.view addSubview:lbl];
        
        [logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(licenceLbl.mas_bottom).offset(idx*20 + 5);
            make.left.equalTo(licenceLbl);
            make.width.height.equalTo(@20);
        }];
        
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(logo).offset(-2);
            make.left.equalTo(logo.mas_right);
            make.height.equalTo(@26);
        }];
        
    }];
    
    [carImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.bottom.equalTo(@(-120));
    }];
    
    [licenceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carImgv.mas_bottom).offset(10);
        make.left.equalTo(@15);
        make.height.equalTo(@30);
    }];
    
    [isNoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(isRightBtn);
        make.right.equalTo(isRightBtn.mas_left).offset(-15);
        make.width.equalTo(@(80));
        make.height.equalTo(@(34));
    }];
    
    [isRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.popupController.containerView.mas_bottom).offset(20);
        make.centerX.equalTo(self.popupController.backgroundView.mas_centerX);
        make.width.equalTo(@(80));
        make.height.equalTo(@(34));
    }];
    
    [unrecognizedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(isRightBtn);
        make.left.equalTo(isRightBtn.mas_right).offset(15);
        make.width.equalTo(@(80));
        make.height.equalTo(@(34));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAction:(UIButton *)btn {
    if (self.btnAction) {
        self.btnAction(btn.tag);
    }
}

- (void)bgViewDidTap {
    [self.popupController dismiss];
}

@end
