
//
//  ISSThirdDetailTopTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2517/11/6.
//  Copyright © 2517年 iSoftStone. All rights reserved.
//

#import "ISSThirdDetailTopTableViewCell.h"

@interface ISSThirdDetailTopTableViewCell()
{
    UILabel         * addressNameLabel;
    UILabel         * addressLabel;
    UILabel         * patrolCompanyNameLabel;
    UILabel         * patrolCompanyLabel;
    UILabel         * stateNameLabel;
    UILabel         * stateLabel;
    UILabel         * typeNameLabel;
    UILabel         * typeLabel;
    UILabel         * buildCompanyNameLabel;
    UILabel         * buildCompanyLabel;
    UILabel         * implementCompanyNameLabel;
    UILabel         * implementCompanyLabel;
    UILabel         * superviseCompanyNameLabel;
    UILabel         * superviseCompanyLabel;
    UILabel         * visitTimeNameLabel;
    UILabel         * visitTimeLabel;
    
    UIImageView     * line;
    
}

@end

@implementation ISSThirdDetailTopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorWhite;
        
        addressNameLabel = [[UILabel alloc]initForAutoLayout];
        addressNameLabel.font = ISSFont14;
        addressNameLabel.textColor = ISSColorDardGray6;
        addressNameLabel.text = @"巡查地点：";
        [self.contentView addSubview:addressNameLabel];
        [self.contentView addConstraints:[addressNameLabel constraintsTopInContainer:20]];
        [self.contentView addConstraints:[addressNameLabel constraintsLeftInContainer:16]];
        
        addressLabel = [[UILabel alloc]initForAutoLayout];
        addressLabel.font = ISSFont14;
        addressLabel.textColor = ISSColorDardGray2;
        addressLabel.text = @"武汉光谷中心城武汉光谷中心城武汉光谷中心城武汉光谷中心城武汉光谷中心城武汉光谷中心城";
        addressLabel.numberOfLines = 2;
        [self.contentView addSubview:addressLabel];
        [self.contentView addConstraints:[addressLabel constraintsTopInContainer:20]];
        [self.contentView addConstraints:[addressLabel constraintsLeft:0 FromView:addressNameLabel]];
        [self.contentView addConstraints:[addressLabel constraintsRightInContainer:16]];

        
        patrolCompanyNameLabel = [[UILabel alloc]initForAutoLayout];
        patrolCompanyNameLabel.font = ISSFont14;
        patrolCompanyNameLabel.textColor = ISSColorDardGray6;
        patrolCompanyNameLabel.text = @"巡查单位：";
        [self.contentView addSubview:patrolCompanyNameLabel];
        [self.contentView addConstraints:[patrolCompanyNameLabel constraintsTop:25 FromView:addressNameLabel]];
        [self.contentView addConstraints:[patrolCompanyNameLabel constraintsLeftInContainer:16]];
        
        patrolCompanyLabel = [[UILabel alloc]initForAutoLayout];
        patrolCompanyLabel.font = ISSFont14;
        patrolCompanyLabel.textColor = ISSColorDardGray2;
        patrolCompanyLabel.text = @"武汉巡查有限公司";
        [self.contentView addSubview:patrolCompanyLabel];
        [self.contentView addConstraints:[patrolCompanyLabel constraintsTop:25 FromView:addressNameLabel]];
        [self.contentView addConstraints:[patrolCompanyLabel constraintsLeft:0 FromView:patrolCompanyNameLabel]];
        
        stateNameLabel = [[UILabel alloc]initForAutoLayout];
        stateNameLabel.font = ISSFont14;
        stateNameLabel.textColor = ISSColorDardGray6;
        stateNameLabel.text = @"报告状态：";
        [self.contentView addSubview:stateNameLabel];
        [self.contentView addConstraints:[stateNameLabel constraintsTop:25 FromView:patrolCompanyNameLabel]];
        [self.contentView addConstraints:[stateNameLabel constraintsLeftInContainer:16]];
        
        stateLabel = [[UILabel alloc]initForAutoLayout];
        stateLabel.font = ISSFont14;
        stateLabel.textColor = ISSColorDardGray2;
        stateLabel.text = @"报告中";
        [self.contentView addSubview:stateLabel];
        [self.contentView addConstraints:[stateLabel constraintsTop:25 FromView:patrolCompanyNameLabel]];
        [self.contentView addConstraints:[stateLabel constraintsLeft:0 FromView:stateNameLabel]];
        
        typeNameLabel = [[UILabel alloc]initForAutoLayout];
        typeNameLabel.font = ISSFont14;
        typeNameLabel.textColor = ISSColorDardGray6;
        typeNameLabel.text = @"报告类型：";
        [self.contentView addSubview:typeNameLabel];
        [self.contentView addConstraints:[typeNameLabel constraintsTop:25 FromView:stateNameLabel]];
        [self.contentView addConstraints:[typeNameLabel constraintsLeftInContainer:16]];
        
        typeLabel = [[UILabel alloc]initForAutoLayout];
        typeLabel.font = ISSFont14;
        typeLabel.textColor = ISSColorDardGray2;
        typeLabel.text = @"工地巡查报告";
        [self.contentView addSubview:typeLabel];
        [self.contentView addConstraints:[typeLabel constraintsTop:25 FromView:stateNameLabel]];
        [self.contentView addConstraints:[typeLabel constraintsLeft:0 FromView:typeNameLabel]];
        
        buildCompanyNameLabel = [[UILabel alloc]initForAutoLayout];
        buildCompanyNameLabel.font = ISSFont14;
        buildCompanyNameLabel.textColor = ISSColorDardGray6;
        buildCompanyNameLabel.text = @"建设单位：";
        [self.contentView addSubview:buildCompanyNameLabel];
        [self.contentView addConstraints:[buildCompanyNameLabel constraintsTop:25 FromView:typeNameLabel]];
        [self.contentView addConstraints:[buildCompanyNameLabel constraintsLeftInContainer:16]];
        
        buildCompanyLabel = [[UILabel alloc]initForAutoLayout];
        buildCompanyLabel.font = ISSFont14;
        buildCompanyLabel.textColor = ISSColorDardGray2;
//        buildCompanyLabel.numberOfLines = 2;
        buildCompanyLabel.text = @"武汉建设单位有限公司";
        [self.contentView addSubview:buildCompanyLabel];
        [self.contentView addConstraints:[buildCompanyLabel constraintsTop:25 FromView:typeNameLabel]];
        [self.contentView addConstraints:[buildCompanyLabel constraintsLeft:0 FromView:buildCompanyNameLabel]];
        
        implementCompanyNameLabel = [[UILabel alloc]initForAutoLayout];
        implementCompanyNameLabel.font = ISSFont14;
        implementCompanyNameLabel.textColor = ISSColorDardGray6;
        implementCompanyNameLabel.text = @"施工单位：";
        [self.contentView addSubview:implementCompanyNameLabel];
        [self.contentView addConstraints:[implementCompanyNameLabel constraintsTop:25 FromView:buildCompanyNameLabel]];
        [self.contentView addConstraints:[implementCompanyNameLabel constraintsLeftInContainer:16]];
        
        implementCompanyLabel = [[UILabel alloc]initForAutoLayout];
        implementCompanyLabel.font = ISSFont14;
        implementCompanyLabel.textColor = ISSColorDardGray2;
        implementCompanyLabel.text = @"武汉施工单位有限公司";
        [self.contentView addSubview:implementCompanyLabel];
        [self.contentView addConstraints:[implementCompanyLabel constraintsTop:25 FromView:buildCompanyNameLabel]];
        [self.contentView addConstraints:[implementCompanyLabel constraintsLeft:0 FromView:implementCompanyNameLabel]];
        
        superviseCompanyNameLabel = [[UILabel alloc]initForAutoLayout];
        superviseCompanyNameLabel.font = ISSFont14;
        superviseCompanyNameLabel.textColor = ISSColorDardGray6;
        superviseCompanyNameLabel.text = @"监理单位：";
        [self.contentView addSubview:superviseCompanyNameLabel];
        [self.contentView addConstraints:[superviseCompanyNameLabel constraintsTop:25 FromView:implementCompanyNameLabel]];
        [self.contentView addConstraints:[superviseCompanyNameLabel constraintsLeftInContainer:16]];
        
        superviseCompanyLabel = [[UILabel alloc]initForAutoLayout];
        superviseCompanyLabel.font = ISSFont14;
        superviseCompanyLabel.textColor = ISSColorDardGray2;
        superviseCompanyLabel.text = @"武汉监理单位有限公司";
        [self.contentView addSubview:superviseCompanyLabel];
        [self.contentView addConstraints:[superviseCompanyLabel constraintsTop:25 FromView:implementCompanyNameLabel]];
        [self.contentView addConstraints:[superviseCompanyLabel constraintsLeft:0 FromView:superviseCompanyNameLabel]];
        
        visitTimeNameLabel = [[UILabel alloc]initForAutoLayout];
        visitTimeNameLabel.font = ISSFont14;
        visitTimeNameLabel.textColor = ISSColorDardGray6;
        visitTimeNameLabel.text = @"回访时间：";
        [self.contentView addSubview:visitTimeNameLabel];
        [self.contentView addConstraints:[visitTimeNameLabel constraintsTop:25 FromView:superviseCompanyNameLabel]];
        [self.contentView addConstraints:[visitTimeNameLabel constraintsLeftInContainer:16]];
        
        visitTimeLabel = [[UILabel alloc]initForAutoLayout];
        visitTimeLabel.font = ISSFont14;
        visitTimeLabel.textColor = ISSColorDardGray2;
        visitTimeLabel.text = @"2017-09-30";
        [self.contentView addSubview:visitTimeLabel];
        [self.contentView addConstraints:[visitTimeLabel constraintsTop:25 FromView:superviseCompanyNameLabel]];
        [self.contentView addConstraints:[visitTimeLabel constraintsLeft:0 FromView:visitTimeNameLabel]];
        
        line = [[UIImageView alloc]initForAutoLayout];
        line.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:line];
        [self.contentView addConstraints:[line constraintsSize:CGSizeMake(kScreenWidth - 32, 0.5)]];
        [self.contentView addConstraints:[line constraintsBottomInContainer:12]];
        [self.contentView addConstraints:[line constraintsLeftInContainer:16]];
    }
    return self;
}

- (void)conFigDataThirdDetailModel:(ISSThirdDetailModel *)thirdDetailModel
{
    addressLabel.text = thirdDetailModel.address;
    patrolCompanyLabel.text = thirdDetailModel.company;
    typeLabel.text = thirdDetailModel.category;
    buildCompanyLabel.text = thirdDetailModel.developmentCompany;
    implementCompanyLabel.text = thirdDetailModel.constructionCompany;
    superviseCompanyLabel.text = thirdDetailModel.supervisionCompany;
    NSString * time = [thirdDetailModel.visitDate substringWithRange:NSMakeRange(0, 10)];
    visitTimeLabel.text = time;
}

@end
