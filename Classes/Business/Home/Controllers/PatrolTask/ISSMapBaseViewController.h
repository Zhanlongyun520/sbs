//
//  ISSMapBaseViewController.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/13.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSViewController.h"
#import "Masonry.h"
#import "ISSAreaPolyline.h"
#import <MAMapKit/MAMapKit.h>

@interface ISSMapBaseViewController : ISSViewController <MAMapViewDelegate>
{
    MAMapView *_mapView;
    
    ISSAreaPolyline *_areaPolyline;
}

- (MAPolylineRenderer *)getAreaPolylineRenderer:(ISSAreaPolyline *)overlay;

@end
