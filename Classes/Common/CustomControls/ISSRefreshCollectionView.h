//
//  ISSRefreshCollectionView.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/20.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISSRefreshCollectionView : UICollectionView

@property (nonatomic, assign) BOOL automaticallyRefresh;        //默认yes, 上拉自动加载

- (void)refreshNow:(BOOL)isRefresh
   refreshViewType:(ISSRefreshViewType)type;

- (void)setRefreshingImages:(NSArray *)images
                  withState:(ISSRefreshViewStatus)viewState
                   position:(ISSRefreshViewType)position;

- (void)startHeadRefresh;
- (void)endHeadRefresh;
- (void)startFootRefresh;
- (void)endFootFefresh;

- (void)hiddenHeader;
- (void)showHeader;

- (void)hiddenFooter;
- (void)showFooter;

- (void)setView:(ISSRefreshViewType)type
           text:(NSString *)text
         status:(ISSRefreshViewStatus)status;

@end
