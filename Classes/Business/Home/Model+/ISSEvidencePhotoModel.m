//
//  ISSEvidencePhotoModel.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSEvidencePhotoModel.h"

@implementation ISSPhotoUserModel

@synthesize description;

@end


@implementation ISSEvidencePhotoModel

- (void)setTakePhoroUser:(NSDictionary *)takePhoroUser {
    _takePhoroUser = [[ISSPhotoUserModel alloc] initWithDictionary:takePhoroUser error:nil];
}

@end
