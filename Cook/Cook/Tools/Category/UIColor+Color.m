//
//  UIColor+Color.m
//  Cook
//
//  Created by 诸超杰 on 16/4/28.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "UIColor+Color.h"

@implementation UIColor (Color)
+ (UIColor *)colorWithRed:(CGFloat)redFloat Blue:(CGFloat)blueFloat Yellor:(CGFloat)yellorFloat {
    return [UIColor colorWithRed:redFloat / 255.0 green:yellorFloat / 255.0 blue:blueFloat / 255.0 alpha:1];
}
@end
