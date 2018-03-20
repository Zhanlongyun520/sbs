//
//  ISSThirdAddReportTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/3.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdAddReportTableViewCell.h"

#define kMaxColumn 3 // 每行显示数量
#define MaxImageCount 9 // 最多显示图片个数
#define imageWith   54
#define leftWith   32
#define top        160

#define spaceX   10
#define spaceY   12




@interface ISSThirdAddReportTableViewCell()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView     * titleIV;
    UILabel         * titleLabel;
    UIImageView     * line;
    NSInteger         imageButtonCount;
    int               imageLine;
    
}
@property(nonatomic , strong) UIButton        * addImageButton;


@end

@implementation ISSThirdAddReportTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorWhite;
        
        imageButtonCount = 0;
        
        titleIV = [[UIImageView alloc]initForAutoLayout];
        titleIV.image = [UIImage imageNamed:@"addcolumn"];
        [self.contentView addSubview:titleIV];
        [self.contentView addConstraints:[titleIV constraintsTopInContainer:16]];
        [self.contentView addConstraints:[titleIV constraintsLeftInContainer:16]];
        
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = ISSFont14;
        titleLabel.textColor = ISSColorDardGray6;
        titleLabel.text = @"报告内容";
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraints:[titleLabel constraintsTopInContainer:18]];
        [self.contentView addConstraints:[titleLabel constraintsLeft:12 FromView:titleIV]];
        
        self.viewBG = [[UIImageView alloc]initWithFrame:CGRectMake(16, 54, kScreenWidth- 32, 176)];
        _viewBG.backgroundColor = ISSColorViewBg;
        [self.contentView addSubview:_viewBG];
        
        self.textView = [[XTTextView alloc]initForAutoLayout];
        _textView.backgroundColor = ISSColorViewBg;
        _textView.font = ISSFont14;
        _textView.textColor = ISSColorDardGray2;
        _textView.placeholder = @"请输入内容";
        _textView.placeholderTextColor = ISSColorDardGray9;
        [self.contentView addSubview:_textView];
        [self.contentView addConstraints:[_textView constraintsSize:CGSizeMake(kScreenWidth - 64, 90)]];
        [self.contentView addConstraints:[_textView constraintsTopInContainer:54]];
        [self.contentView addConstraints:[_textView constraintsLeftInContainer:32]];
        
        line = [[UIImageView alloc]initForAutoLayout];
        line.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:line];
        [self.contentView addConstraints:[line constraintsSize:CGSizeMake(kScreenWidth - 64, 0.5)]];
        [self.contentView addConstraints:[line constraintsTopInContainer:144]];
        [self.contentView addConstraints:[line constraintsLeftInContainer:32]];
        
        _addImageButton = [[UIButton alloc] initWithFrame:CGRectMake(32, 144 + 16, imageWith, imageWith)];
        [_addImageButton setImage:[UIImage imageNamed:@"attachment"] forState:UIControlStateNormal];
        _addImageButton.layer.borderColor = [ISSColorAddImageButton CGColor];
        _addImageButton.layer.borderWidth = 1.0f;
        _addImageButton.layer.masksToBounds = YES;
        [_addImageButton addTarget:self action:@selector(addImageButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addImageButton];
        
    }
    if (self.imagesArray.count != 0) {
        [self imageArrayAddButton];
    }
    return self;
}

#pragma mark - Button Action
- (void)imageButtonAction:(UIButton *)button
{
    
}


- (void)addImageButtonAction
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self.controller presentViewController:picker animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* orImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        if (orImage) {
            imageButtonCount ++;
            
            [self.imagesArray addObject:orImage];
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:orImage forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            [picker dismissViewControllerAnimated:YES completion:nil];
        }else {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"图片无效"];
        }
        
    }
}

- (void)imageArrayAddButton
{
    for (int i=0; i<self.imagesArray.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:self.imagesArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        if (count > 2 && i > 0) {
            
            UIButton *btn = self.subviews[i];
            btn.size = CGSizeMake(imageWith, imageWith);
            CGFloat btnX = leftWith + (imageWith + spaceX)*(count-2);
            imageLine =  (btnX + imageWith)/(kScreenWidth - 64);
            int column = (kScreenWidth - 64)/(imageWith + spaceX);
        
            if (i == 1) {
                
                if (btnX+imageWith > kScreenWidth-64) {
                    int j = (count-2) % column;
                    btn.x = leftWith + (imageWith + spaceX)*j;
                    btn.y = imageLine * (spaceX + imageWith) + top;
                }else{
                    btn.x = btnX;
                    btn.y = imageLine * (spaceX + imageWith) + top;
                }
            }else{
                
                CGFloat btnX1 = leftWith + (imageWith + spaceX)*(i-2);
                int line1 =  (btnX1 + imageWith)/(kScreenWidth - 64);
                int j = (i-2) % column;
                btn.x = leftWith + (imageWith + spaceX)*j;
                btn.y = line1 * (spaceX + imageWith) + top;
            }
            if (imageLine != 0 && _viewBG.height != 176 + (spaceX + imageWith)*(imageLine)) {
                _viewBG.height = 176 + (spaceX + imageWith)*(imageLine);
                
                self.thirdAddReportCellBlock(246 + (spaceX + imageWith)*(imageLine),self.imagesArray);
            }
        }
    }
}

- (NSMutableArray *)imagesArray
{
    if (_imagesArray == nil) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

@end
