//
//  Makingsteps.m
//  Cook
//
//  Created by 诸超杰 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "Makingsteps.h"

@implementation Makingsteps
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    [super setValue:value forUndefinedKey:key];
}
- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([key isEqualToString:@"pause"]) {
        self.pause = [value boolValue];
        return;
    }
    [super setValue:value forKey:key];
}
@end
