//
//  CommentsModel.m
//  Cook
//
//  Created by 诸超杰 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "CommentsModel.h"

@implementation CommentsModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    [super setValue:value forUndefinedKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"user"]) {
        NSDictionary *dic = (NSDictionary *)value;
        self.UserModel = [[NewUserModel alloc] init];
        [self.UserModel setValuesForKeysWithDictionary:dic];
        return;
    }
    if ([key isEqualToString:@"isLike"]) {
        self.isLike = [value boolValue];
        return;
    }
    [super setValue:value forKey:key];
}
@end
