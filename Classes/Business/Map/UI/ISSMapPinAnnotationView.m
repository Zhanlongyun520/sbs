//
//  ISSMapPinAnnotationView.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2018/1/2.
//  Copyright © 2018年 iSoftStone. All rights reserved.
//

#import "ISSMapPinAnnotationView.h"

@implementation ISSMapPinAnnotationView

- (instancetype)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        _selectedImageView = [[UIImageView alloc] init];
        _selectedImageView.frame = CGRectMake(-6, 27, 40, 40);
        _selectedImageView.image = [UIImage imageNamed:@"map-point-selected"];
        _selectedImageView.hidden = YES;
        [self addSubview:_selectedImageView];
    }
    return self;
}

@end
