//
//  LatestDevelopmentModel.m
//  Cook
//
//  Created by 叶旺 on 16/4/27.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "LatestDevelopmentModel.h"

@implementation LatestDevelopmentModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    [super setValue:value forUndefinedKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([key isEqualToString:@"operator"]) {
        NSDictionary *dic = (NSDictionary *)value;
        self.operatorModel = [[HomeNewUserModel alloc] init];
        [self.operatorModel setValuesForKeysWithDictionary:dic];
        return;
    }
    if ([key isEqualToString:@"cookbook"]) {
        NSDictionary *dic = (NSDictionary *)value;
        if (YES/*[self.actionTag isEqualToString:@"4"]*/) {
            self.recipeModel = [[RecipeListWaterfallModel alloc] init];
            [self.recipeModel setValuesForKeysWithDictionary:dic];
            return;
        }
    }
    if ([key isEqualToString:@"work"]) {
        NSDictionary *dic = (NSDictionary *)value;
        self.newworkModel = [[NewWorkWaterfallModel alloc] init];
        [self.newworkModel setValuesForKeysWithDictionary:dic];
        return;
    }
    [super setValue:value forKey:key];
}
@end
