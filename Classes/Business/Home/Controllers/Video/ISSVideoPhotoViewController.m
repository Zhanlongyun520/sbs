//
//  ISSVideoPhotoViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/26.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSVideoPhotoViewController.h"
#import "ISSVideoPhotoManager.h"
#import "ISSVideoPhotoCell.h"
#import "Masonry.h"
#import "LGPhoto.h"

@interface ISSVideoPhotoViewController () <UICollectionViewDelegate, UICollectionViewDataSource, LGPhotoPickerBrowserViewControllerDataSource, LGPhotoPickerBrowserViewControllerDelegate>
{
    NSMutableArray *_dataList;
    
    UICollectionView *_collectionView;
}
@end

@implementation ISSVideoPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"视频抓拍";
    
    self.isHiddenTabBar = YES;
    
    _dataList = @[].mutableCopy;
    
    CGFloat margin = 10;
    CGFloat itemWidth = (kScreenWidth - 5 * margin) / 4.0;
    CGFloat itemHeight = itemWidth;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.alwaysBounceHorizontal = NO;
    _collectionView.contentInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    [_collectionView registerClass:[ISSVideoPhotoCell class] forCellWithReuseIdentifier:@"ISSVideoPhotoCell"];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LGPhotoPickerBrowserPhoto *photo = [_dataList objectAtIndex:indexPath.row];
    
    ISSVideoPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ISSVideoPhotoCell" forIndexPath:indexPath];
    cell.url = photo.photoURL;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self pushPhotoBroswer:indexPath];
}

- (void)loadData {
    [_dataList removeAllObjects];
    NSArray *urlArray = [ISSVideoPhotoManager getPhotos:_code];
    for (NSURL *url in urlArray) {
        LGPhotoPickerBrowserPhoto *photo = [[LGPhotoPickerBrowserPhoto alloc] init];
        photo.photoURL = url;
        [_dataList addObject:photo];
    }
    
    [_collectionView reloadData];
}

- (void)pushPhotoBroswer:(NSIndexPath *)indexPath {
    LGPhotoPickerBrowserViewController *browserViewController = [[LGPhotoPickerBrowserViewController alloc] init];
    browserViewController.delegate = self;
    browserViewController.dataSource = self;
    browserViewController.showType = LGShowImageTypeImageURL;
    browserViewController.currentIndexPath = indexPath;
    [self presentViewController:browserViewController animated:YES completion:nil];
}

#pragma mark - LGPhotoPickerBrowserViewControllerDataSource

- (NSInteger)photoBrowser:(LGPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section{
    return _dataList.count;
}

- (id<LGPhotoPickerBrowserPhoto>)photoBrowser:(LGPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath{
    return [_dataList objectAtIndex:indexPath.item];
}

@end
