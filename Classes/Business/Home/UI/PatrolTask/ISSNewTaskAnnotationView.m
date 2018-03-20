//
//  ISSNewTaskAnnotationView.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSNewTaskAnnotationView.h"

@interface ISSNewTaskAnnotationView () {
    UILabel *_addressLabel;
}
@end

@implementation ISSNewTaskAnnotationView

- (instancetype)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 1, 102, 18)];
        _addressLabel.textAlignment = NSTextAlignmentCenter;
        _addressLabel.textColor = [UIColor grayColor];
        _addressLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_addressLabel];
    }
    return self;
}

- (void)setAddress:(NSString *)address {
    _address = address;
    
    _addressLabel.text = address;
}

@end
