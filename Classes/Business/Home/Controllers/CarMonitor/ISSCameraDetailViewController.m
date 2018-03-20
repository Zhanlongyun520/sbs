//
//  ISSCameraDetailViewController.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSCameraDetailViewController.h"
#import "ISSCarTrackModel.h"
#import "Masonry.h"

#import "UIImageView+WebCache.h"

@interface ISSCameraDetailViewController ()

@end

@implementation ISSCameraDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"摄像头详情";
    self.isHiddenTabBar = YES;
    
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"设备编号：";
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:13.0];
    [headView addSubview:titleLabel];
    
    UILabel *nameLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor darkTextColor];
        label.font = [UIFont systemFontOfSize:14.0];
        [headView addSubview:label]; label;
    });
    
    UILabel *dateLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:13.0];
        [headView addSubview:label]; label;
    });
    
    UIImageView *addrImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"track_loaction_gray"]];
    [headView addSubview:addrImv];
    
    UILabel *addrLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor darkTextColor];
        label.font = [UIFont systemFontOfSize:14.0];
        [headView addSubview:label]; label;
    });
    
    UILabel *licenceLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor darkTextColor];
        label.font = [UIFont systemFontOfSize:15];
        [contentView addSubview:label]; label;
    });
    
    UIScrollView *imgsContent = [[UIScrollView alloc] init];
    [contentView addSubview:imgsContent];
    
    
    NSString *dateTime = self.model.dateTime.length > 10 ? [self.model.dateTime substringToIndex:10] : self.model.dateTime;
    dateTime = [NSString stringWithFormat:@"拍摄时间: %@",dateTime];
    NSString *address = (self.model.addr.length > 0) ? self.model.addr :@"未知地点";
    
    nameLabel.text = self.model.deviceName;
    dateLabel.text = dateTime;
    addrLabel.text = address;
    licenceLabel.text = self.model.licence;
    
    NSArray *imgs = [self.model.imgList componentsSeparatedByString:@","];
    [imgs enumerateObjectsUsingBlock:^(NSString *path, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imgv = [imgsContent viewWithTag:idx+1000];
        
        if (!imgv) {
            imgv = [[UIImageView alloc] init];
            imgv.tag = idx+1000;
            [imgv sd_setImageWithURL:[NSURL URLWithString:path]
                    placeholderImage:[UIImage imageNamed:@"car_placeholder"]];
            [imgsContent addSubview:imgv];
            
            NSInteger totalCount = imgs.count; //总数
            NSInteger numberPerRow = 3; //每行多少个
            NSInteger rows = ceilf(totalCount/(numberPerRow/1.0)); //总共多少行
            
            CGFloat margin = 5.0, btnWidth = (CGRectGetWidth([UIScreen mainScreen].bounds)-60)/3;
            CGFloat x = margin + (idx % numberPerRow) * (btnWidth+margin);
            CGFloat y = margin + (idx % rows) * (btnWidth+margin);
            
            imgv.frame = CGRectMake(x, y, btnWidth, btnWidth);
        } else {
            [imgv sd_setImageWithURL:[NSURL URLWithString:path]
                    placeholderImage:[UIImage imageNamed:@"car_placeholder"]];
        }
    }];
    
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(@96);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView);
        make.top.equalTo(headView.mas_bottom).offset(10);
        make.right.equalTo(headView);
        make.bottom.equalTo(@0);
    }];
    
    [imgsContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(licenceLabel.mas_bottom);
        make.bottom.right.equalTo(@-10);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(@0);
        make.height.equalTo(@44);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right);
        make.top.equalTo(titleLabel);
        make.height.equalTo(titleLabel);
    }];
    
    [addrImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel).offset(5);
        make.centerY.equalTo(addrLabel);
        make.height.equalTo(@13);
        make.width.equalTo(@10);
    }];
    
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.top.equalTo(titleLabel);
        make.height.equalTo(@44);
    }];
    
    [addrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addrImv.mas_right).offset(5);
        make.right.equalTo(@-25);
        make.bottom.equalTo(@(-20));
    }];
    
    [licenceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.top.equalTo(@0);
        make.height.equalTo(titleLabel);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
