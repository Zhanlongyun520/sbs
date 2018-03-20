//
//  PopupPickerView.h
//  XHP_PopupPickerView
//
//  Created by xiaohaiping on 16/8/9.
//  Copyright © 2016年 HaoHeHealth. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PopupPickerControlBlock)(NSArray *indexs);

@interface PopupPickerControl : UIView

+ (void)setCellClass:(Class )cellClass;

+ (void)showWithTitle:(NSString *)title
           WithTitles:(NSArray *)titles
         defaultIndex:(NSArray *)index
        selectedBlock:(PopupPickerControlBlock)selectedHandle;

- (void)hideView;

@end
