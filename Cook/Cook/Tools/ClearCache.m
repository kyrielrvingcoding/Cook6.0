//
//  ClearCache.m
//  Cook
//
//  Created by 诸超杰 on 16/4/28.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "ClearCache.h"

@implementation ClearCache

//清除网络图片
+ (BOOL)clearSDWebImageCache {
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    return YES;
}

//得到网络图片的缓存数量，单位是MB
+ (CGFloat)getSDWebImageCache {
   return [[SDImageCache sharedImageCache] getSize];
}

@end
