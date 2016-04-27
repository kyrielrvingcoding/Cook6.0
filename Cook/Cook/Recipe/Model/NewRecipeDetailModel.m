//
//  NewRecipeDetailModel.m
//  Cook
//
//  Created by 诸超杰 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "NewRecipeDetailModel.h"

@implementation NewRecipeDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    [super setValue:value forUndefinedKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"ingredients"]) {
        NSArray *array = (NSArray *)value;
        self.ingredientsArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in array) {
            IngredientsModel *model = [[IngredientsModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.ingredientsArray addObject:model];
        }
        return;
    }
    if ([key isEqualToString:@"makingSteps"]) {
        NSArray *array = (NSArray *)value;
        self.makingStepsArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in array) {

            Makingsteps *model = [[Makingsteps alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.makingStepsArray addObject:model];
        }
        return;
    }
    if ([key isEqualToString:@"comments"]) {
        NSArray *array = (NSArray *)value;
        self.commentsArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in array) {
            CommentsModel *model = [[CommentsModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.commentsArray addObject:model];
        }
        return;
    }
    if ([key isEqualToString:@"referrer"]) {
        NSDictionary *dic = (NSDictionary *)value;
        self.userModel = [[NewUserModel alloc] init];
        [self.userModel setValuesForKeysWithDictionary:dic];
        return;
    }
    
    if ([key isEqualToString:@"isCollect"]) {
       
        self.isCollect = [value boolValue];
        return;
    }
    if ([key isEqualToString:@"isLike"]) {
        self.isLike = [value boolValue];
        return;
    }
    if ([key isEqualToString:@"isConcern"]) {
        self.isConcern = [value boolValue];
        return;
    }
    [super setValue:value forKey:key];
}
@end
