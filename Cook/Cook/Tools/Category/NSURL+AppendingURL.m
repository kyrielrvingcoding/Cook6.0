//
//  NSURL+AppendingURL.m
//  Cooker
//
//  Created by 叶旺 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "NSURL+AppendingURL.h"

@implementation NSURL (AppendingURL)

+ (NSURL *)stringAppendingToURLWithString:(NSString *)string {
    NSString *imageUrl = [PICFRONT_URL stringByAppendingString:[NSString stringWithFormat:@"%@.jpg",string]];
    NSURL *url = [NSURL URLWithString:imageUrl];
    return url;
}

@end
