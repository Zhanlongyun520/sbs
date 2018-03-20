//
//  NSString+Size.m
//
//
//  Created by WuLeilei.
//  Copyright (c) 2016年 WuLeilei. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGFloat)getHeightOfFont:(UIFont *)textFont width:(CGFloat)textWidth {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary *attributes = @{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:paragraphStyle};
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(textWidth, CGFLOAT_MAX)
                                     options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                  attributes:attributes
                                     context:nil];
    CGSize requiredSize = rect.size;
    
    return ceilf(requiredSize.height);
}

- (CGFloat)getWidthOfFont:(UIFont *)textFont height:(CGFloat)textHeight {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary *attributes = @{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:paragraphStyle};
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, textHeight)
                                     options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                  attributes:attributes
                                     context:nil];
    CGSize requiredSize = rect.size;
    
    return ceilf(requiredSize.width);
}

@end
