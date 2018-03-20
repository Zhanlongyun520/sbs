//
//  ISSEvidenceTableViewCell.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSEvidenceTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ISSEvidenceTableViewCell()

@property (nonatomic, strong) UIImageView *headView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *companyLabel;
@property (nonatomic, strong) UILabel *addrLabel;

@property (nonatomic, strong) UIView *imgsContent;

@end

@implementation ISSEvidenceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *contentView = self.contentView;
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@10);
            make.right.bottom.equalTo(@(-10));
        }];
        
        _headView = ({
            UIImageView *headView = [[UIImageView alloc] init];
            headView.layer.cornerRadius = 18;
            headView.clipsToBounds = YES;
            [contentView addSubview:headView];
            
            [headView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@15);
                make.left.equalTo(@10);
                make.height.equalTo(@36);
                make.width.equalTo(@36);
            }];
            
            headView;
        });
        
        _nameLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:16];
            label.textColor = [UIColor darkTextColor];
            [contentView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.headView.mas_right).offset(5);
                make.top.equalTo(self.headView.mas_top);
            }];
            
            label;
        });
        
        _dateLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor darkGrayColor];
            [contentView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.nameLabel);
                make.top.equalTo(self.nameLabel.mas_bottom).offset(2);
                make.width.equalTo(@120);
            }];
            
            label;
        });
        
        _companyLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 2;
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor darkGrayColor];
            label.textAlignment = NSTextAlignmentRight;
            [contentView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.dateLabel.mas_right).offset(10);
                make.right.equalTo(@(-10));
                make.centerYWithinMargins.equalTo(self.headView);
            }];
            
            label;
        });
        
        _imgsContent = ({
            UIView *view = [[UIView alloc] init];
            [contentView addSubview:view]; view;
        });
        
        _addrLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor darkGrayColor];
            label.textAlignment = NSTextAlignmentRight;
            [contentView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(@(-5));
                make.left.equalTo(self.headView);
                make.height.equalTo(@20);
            }];
            
            label;
        });
        
        [self.imgsContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView.mas_bottom).offset(10);
            make.bottom.equalTo(self.addrLabel.mas_top).offset(-5);
            make.right.equalTo(@(-10));
            make.left.equalTo(@10);
        }];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillDataSource:(ISSEvidencePhotoModel *)model {
    NSArray *imgs = [model.smallPhotoSrc componentsSeparatedByString:@","];
    [imgs enumerateObjectsUsingBlock:^(NSString *path, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imgv = [self.imgsContent viewWithTag:idx+1000];
        
        if (!imgv) {
            imgv = [[UIImageView alloc] init];
            imgv.tag = idx+1000;
            [imgv setImageWithPath:model.smallPhotoSrc];
            [self.imgsContent addSubview:imgv];
            
            NSInteger totalCount = imgs.count; //总数
            NSInteger numberPerRow = 3; //每行多少个
            NSInteger rows = ceilf(totalCount/(numberPerRow/1.0)); //总共多少行
            
            CGFloat margin = 5.0, btnWidth = (CGRectGetWidth([UIScreen mainScreen].bounds)-60)/3;
            CGFloat x = margin + (idx % numberPerRow) * (btnWidth+margin);
            CGFloat y = margin + (idx % rows) * (btnWidth+margin);

            imgv.frame = CGRectMake(x, y, btnWidth, btnWidth);
        } else {
            [imgv setImageWithPath:model.smallPhotoSrc];
        }
    }];
    
    ISSPhotoUserModel *userModel = model.takePhoroUser;
    
    [self.headView sd_setImageWithURL:[NSURL URLWithString:userModel.imageData]
                     placeholderImage:[UIImage imageNamed:@"car_placeholder"]];
    self.nameLabel.text = userModel.name;

    self.dateLabel.text = model.takePhotoTime;
    self.companyLabel.text = userModel.address;
    self.addrLabel.text = model.addr;
}

@end
