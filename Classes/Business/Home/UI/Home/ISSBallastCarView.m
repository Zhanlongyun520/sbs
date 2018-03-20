//
//  ISSBallastCarView.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/22.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBallastCarView.h"

@interface ISSBallastCarView ()
{
    UIImageView     * bgView;
    UIImageView     * ballastView;
    UILabel         * plateNumberLabel;
    UIImageView     * addressIV;
    UIImageView     * timeIV;
    UIImageView     * speedIV;
    UILabel         * addressLabel;
    UILabel         * timeLabel;
    UILabel         * speedLabel;


}

@end

@implementation ISSBallastCarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ISSColorBlack colorWithAlphaComponent:0.6];

        bgView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 275)/2, (kScreenHeight - 329 - 15 - 48)/2, 275, 329)];
        bgView.backgroundColor = ISSColorWhite;
        [self addSubview:bgView];
        
        ballastView = [[UIImageView alloc]initForAutoLayout];
        ballastView.image = [UIImage imageNamed:@"timg"];
        [self addSubview:ballastView];
        [self addConstraint:[ballastView constraintCenterXInContainer]];
        [self addConstraint:[ballastView constraintTopEqualToView:bgView]];
        
        plateNumberLabel = [[UILabel alloc]initForAutoLayout];
        plateNumberLabel.font = ISSFont16;
        plateNumberLabel.textColor = ISSColorDardGray2;
        plateNumberLabel.text = @"鄂A000000";
        [self addSubview:plateNumberLabel];
        [self addConstraints:[plateNumberLabel constraintsTop:12 FromView:ballastView]];
        [self addConstraints:[plateNumberLabel constraintsLeftInContainer:(kScreenWidth-275)/2 + 15]];
        
        addressIV = [[UIImageView alloc]initForAutoLayout];
        addressIV.image = [UIImage imageNamed:@"home-address-1"];
        [self addSubview:addressIV];
        [self addConstraints:[addressIV constraintsTop:10 FromView:plateNumberLabel]];
        [self addConstraints:[addressIV constraintsLeftInContainer:(kScreenWidth-275)/2 + 15]];
        
        addressLabel = [[UILabel alloc]initForAutoLayout];
        addressLabel.font = ISSFont13;
        addressLabel.textColor = ISSColorDardGray6;
        addressLabel.text = @"光谷五路交汇处";
        [self addSubview:addressLabel];
        [self addConstraints:[addressLabel constraintsTop:8 FromView:plateNumberLabel]];
        [self addConstraints:[addressLabel constraintsLeft:5 FromView:addressIV]];
        
        timeIV = [[UIImageView alloc]initForAutoLayout];
        timeIV.image = [UIImage imageNamed:@"home-time"];
        [self addSubview:timeIV];
        [self addConstraints:[timeIV constraintsTop:10 FromView:addressLabel]];
        [self addConstraints:[timeIV constraintsLeftInContainer:(kScreenWidth-275)/2 + 15]];
        
        timeLabel = [[UILabel alloc]initForAutoLayout];
        timeLabel.font = ISSFont13;
        timeLabel.textColor = ISSColorDardGray6;
        timeLabel.text = @"2017-11-31 11:00:00";
        [self addSubview:timeLabel];
        [self addConstraints:[timeLabel constraintsTop:7 FromView:addressLabel]];
        [self addConstraints:[timeLabel constraintsLeft:5 FromView:timeIV]];
        
        speedIV = [[UIImageView alloc]initForAutoLayout];
        speedIV.image = [UIImage imageNamed:@"home-speed"];
        [self addSubview:speedIV];
        [self addConstraints:[speedIV constraintsTop:10 FromView:timeLabel]];
        [self addConstraints:[speedIV constraintsLeftInContainer:(kScreenWidth-275)/2 + 15]];
        
        speedLabel = [[UILabel alloc]initForAutoLayout];
        speedLabel.font = ISSFont13;
        speedLabel.textColor = ISSColorDardGray6;
        speedLabel.text = @"60km/h";
        [self addSubview:speedLabel];
        [self addConstraints:[speedLabel constraintsTop:7 FromView:timeLabel]];
        [self addConstraints:[speedLabel constraintsLeft:5 FromView:speedIV]];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_cancelButton setImage:[UIImage imageNamed:@"home-cancel"] forState:UIControlStateNormal];
        [self addSubview:_cancelButton];
        [self addConstraints:[_cancelButton constraintsLeftInContainer:(kScreenWidth - 98 - 25)/2]];
        [self addConstraints:[_cancelButton constraintsTop:15 FromView:bgView]];
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_confirmButton setImage:[UIImage imageNamed:@"home-confirm"] forState:UIControlStateNormal];
        [self addSubview:_confirmButton];
        [self addConstraints:[_confirmButton constraintsLeft:25 FromView:_cancelButton]];
        [self addConstraints:[_confirmButton constraintsTop:15 FromView:bgView]];

    }
    return self;
}




@end
