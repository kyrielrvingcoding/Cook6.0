//
//  UIBarButtonItem+Extension.h
//  XinLangWeiBo
//
//  Created by 叶旺 on 16/3/12.
//  Copyright © 2016年 叶旺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)barButtonItemWithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName;

@end
