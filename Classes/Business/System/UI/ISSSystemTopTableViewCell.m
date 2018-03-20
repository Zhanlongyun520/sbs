
//
//  ISSSystemTopTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSSystemTopTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ISSLoginUserModel.h"
#import "UIImageView+WebImage.h"
#import "Masonry.h"

@interface ISSSystemTopTableViewCell()
{
    UIImageView     * backgroudIV;

}
@end

@implementation ISSSystemTopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorNavigationBar;
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        backgroudIV = [[UIImageView alloc]initForAutoLayout];
        backgroudIV.image = [UIImage imageNamed:@"userbg"];
        [self.contentView addSubview:backgroudIV];
        [self.contentView addConstraints:[backgroudIV constraintsSize:CGSizeMake(kScreenWidth, 227)]];
        
        _headIV = [[UIImageView alloc]initForAutoLayout];
        _headIV.layer.cornerRadius = 35;
        _headIV.layer.masksToBounds = YES;
        _headIV.layer.borderColor = [UIColor whiteColor].CGColor;
        _headIV.layer.borderWidth = 2;
        [self.contentView addSubview:_headIV];
//        [self.contentView addConstraint:[headIV constraintCenterXInContainer]];
//        [self.contentView addConstraints:[headIV constraintsTopInContainer:54]];
        [_headIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@70);
            make.center.equalTo(self.contentView);
        }];
        
        _usernameLabel = [[UILabel alloc]initForAutoLayout];
        _usernameLabel.font = ISSFont18;
        _usernameLabel.textColor = ISSColorWhite;
        _usernameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_usernameLabel];
        [self.contentView addConstraint:[_usernameLabel constraintCenterXInContainer]];
        [self.contentView addConstraints:[_usernameLabel constraintsTop:12 FromView:_headIV]];
        
        _signatureLabel = [[UILabel alloc]initForAutoLayout];
        _signatureLabel.font = ISSFont12;
        _signatureLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        _signatureLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_signatureLabel];
        [self.contentView addConstraint:[_signatureLabel constraintCenterXInContainer]];
        [self.contentView addConstraints:[_signatureLabel constraintsTop:8 FromView:_usernameLabel]];
    }
    return self;
}

@end
