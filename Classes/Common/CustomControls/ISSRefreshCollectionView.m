//
//  ISSRefreshCollectionView.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/20.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSRefreshCollectionView.h"
#import "MJRefresh.h"

@implementation ISSRefreshCollectionView{
    BOOL isHeaderRefresh;
    BOOL isFooterRefresh;
}

- (void)refreshNow:(BOOL)isRefresh
   refreshViewType:(ISSRefreshViewType)type{
    
    isHeaderRefresh = isRefresh;
    isFooterRefresh = NO;
    
    NSArray *idleImages = @[[UIImage imageNamed:@"loading_001"],
                            [UIImage imageNamed:@"loading_002"],
                            [UIImage imageNamed:@"loading_003"],
                            [UIImage imageNamed:@"loading_004"],
                            [UIImage imageNamed:@"loading_005"],
                            [UIImage imageNamed:@"loading_006"],
                            [UIImage imageNamed:@"loading_007"],
                            [UIImage imageNamed:@"loading_008"],
                            [UIImage imageNamed:@"loading_009"],
                            [UIImage imageNamed:@"loading_010"],
                            [UIImage imageNamed:@"loading_011"],
                            [UIImage imageNamed:@"loading_012"],
                            [UIImage imageNamed:@"loading_013"],
                            [UIImage imageNamed:@"loading_014"],
                            [UIImage imageNamed:@"loading_015"],
                            [UIImage imageNamed:@"loading_016"]
                            ];
    
    switch (type) {
        case ISSRefreshViewTypeHeader:{
            [self createHeaderWithImages:idleImages];
        }
            break;
            
        case ISSRefreshViewTypeFooter:{
            [self createFooterWithImages:idleImages];
        }
            break;
            
        case ISSRefreshViewTypeBoth:{
            [self createHeaderWithImages:idleImages];
            [self createFooterWithImages:idleImages];
        }
            break;
            
        default:
            break;
    }
    
    if (isRefresh && (type == ISSRefreshViewTypeHeader || type == ISSRefreshViewTypeBoth)) {
        [self startHeadRefresh];
    }
}

- (void)createHeaderWithImages:(NSArray *)idleImages{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHeaderRefresh)];
    [header setImages:idleImages forState:MJRefreshStateIdle];
    [header setImages:idleImages forState:MJRefreshStatePulling];
    [header setImages:idleImages forState:MJRefreshStateRefreshing];
    // 设置header
    self.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    
}

- (void)createFooterWithImages:(NSArray *)idleImages{
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadFooterRefresh)];
    [footer setImages:idleImages forState:MJRefreshStateRefreshing];
    self.mj_footer = footer;
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.hidden = YES;
    
    [self setView:ISSRefreshViewTypeFooter text:@"加载中 ···" status:ISSRefreshViewStatusRefreshing];
    footer.hidden = YES;
}


- (void)setRefreshingImages:(NSArray *)images
                  withState:(ISSRefreshViewStatus)viewState
                   position:(ISSRefreshViewType)position{
    if (position == ISSRefreshViewTypeHeader && viewState < 3) {
        
    }else if(position == ISSRefreshViewTypeFooter){
        
    }
    
    
    
}

- (void)loadHeaderRefresh{
    if ([self.delegate respondsToSelector:@selector(startHeadRefreshToDo:)]) {
        [self.delegate performSelector:@selector(startHeadRefreshToDo:) withObject:self];
    }else{
        [self.mj_header endRefreshing];
        NSLog(@"未实现下拉刷新事件");
    }
}

- (void)loadFooterRefresh{
    
    if ([self.delegate respondsToSelector:@selector(startFootRefreshToDo:)]) {
        [self.delegate performSelector:@selector(startFootRefreshToDo:) withObject:self];
    }else{
        [self.mj_footer endRefreshing];
        NSLog(@"未实现上拉加载事件");
    }
    
}


- (BOOL)automaticallyRefresh{
    return [(MJRefreshAutoFooter *)self.mj_footer isAutomaticallyRefresh];
}

- (void)setAutomaticallyRefresh:(BOOL)automaticallyRefresh{
    [(MJRefreshAutoFooter *)self.mj_footer setAutomaticallyRefresh:automaticallyRefresh];
}

- (void)hiddenHeader
{
    if (self.mj_header) {
        self.mj_header.hidden = YES;
    }
}

- (void)showHeader
{
    if (self.mj_header) {
        self.mj_header.hidden = NO;
    }
}

- (void)hiddenFooter{
    if (self.mj_footer) {
        self.mj_footer.hidden = YES;
    }
}

- (void)showFooter{
    if (self.mj_footer) {
        self.mj_footer.hidden = NO;
    }
}

- (void)startHeadRefresh{
    [self.mj_header beginRefreshing];
}

- (void)endHeadRefresh{
    [self.mj_header endRefreshing];
}


- (void)startFootRefresh{
    [self.mj_footer beginRefreshing];
}

- (void)endFootFefresh{
    [self.mj_footer endRefreshing];
}

- (void)setView:(ISSRefreshViewType)type
           text:(NSString *)text
         status:(ISSRefreshViewStatus)status{
    if (type == ISSRefreshViewTypeHeader) {
        MJRefreshStateHeader *header = (MJRefreshStateHeader *)self.mj_header;
        [header setTitle:text forState:(MJRefreshState)status];
        
    }else if (type == ISSRefreshViewTypeFooter){
        
        MJRefreshAutoStateFooter * footer = (MJRefreshAutoStateFooter *)self.mj_footer;
        [footer setTitle:text forState:(MJRefreshState)status];
        footer.stateLabel.textColor = ISSColorLightGray;
        footer.stateLabel.font = ISSFont12;
        
    }
}

- (void)dealloc{
    NSLog(@"ISSRefreshCollectionView dealloc");
}

@end
