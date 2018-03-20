//
//  ISSRefreshTableView.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/20.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ISSRefreshViewType){
    ISSRefreshViewTypeNone,
    ISSRefreshViewTypeHeader,
    ISSRefreshViewTypeFooter,
    ISSRefreshViewTypeBoth
};

typedef NS_ENUM(NSInteger, ISSRefreshViewStatus) {
    ISSRefreshViewStatusIdle = 1, // 普通闲置状态
    ISSRefreshViewStatusPulling,    //松手（下拉中才有）
    ISSRefreshViewStatusRefreshing, // 正在刷新中的状态
    ISSRefreshStateWillRefresh,      //即将刷新的状态
    ISSRefreshViewStatusNoMoreData // 所有数据加载完毕，没有更多的数据了（上拉加载更多）
};

@interface ISSRefreshTableView : UITableView

@property (nonatomic, assign) BOOL automaticallyRefresh;        //默认yes, 上拉自动加载


- (id)initWithFrame:(CGRect)frame
              style:(UITableViewStyle)style
         refreshNow:(BOOL)isRefresh
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

@protocol ISSRefreshTableViewDelegate <NSObject>

@optional
- (void)startHeadRefreshToDo:(ISSRefreshTableView *)tableView;
- (void)startFootRefreshToDo:(ISSRefreshTableView *)tableView;

@end
