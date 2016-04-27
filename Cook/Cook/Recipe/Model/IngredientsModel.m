//
//  IngredientsModel.m
//  Cook
//
//  Created by 诸超杰 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "IngredientsModel.h"

@implementation IngredientsModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"isMain"]) {
        self.isMain = [value boolValue];
        return;
    }
    [super setValue:value forKey:key];
}
@end
