//
//  RecipeDetailModel.m
//  Cooker
//
//  Created by 诸超杰 on 16/4/20.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "RecipeDetailModel.h"

@implementation RecipeDetailModel

- (NSMutableArray *)stepListModelArray {
    if (_stepListModelArray == nil) {
        _stepListModelArray = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    return _stepListModelArray;
}

- (NSMutableArray *)materialListModelArray {
    if (_materialListModelArray == nil) {
        _materialListModelArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _materialListModelArray;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    [super setValue:value forUndefinedKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"stepList"]) {
        NSArray *array = (NSArray *)value;
        for (NSDictionary *dic in array) {
            StepListModel *model = [[StepListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.stepListModelArray addObject:model];
        }
        return;
    }
    if ([key isEqualToString:@"materialList"]) {
        NSArray *array = (NSArray *)value;
        for (NSDictionary *dic in array) {
            materialListModel *model = [[materialListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.materialListModelArray addObject:model];
        }
        return;
    }
    if ([key isEqualToString:@"tipList"]) {
        NSArray *array = (NSArray *)value;
        int i = 1;
        self.tipList = [NSString stringWithFormat:@""];
        for (NSDictionary *dic in array) {
            self.tipList = [self.tipList stringByAppendingString:[NSString stringWithFormat:@"%@ ",dic[@"details"]]];
            i ++;
        }
        return;
    }
    [super setValue:value forKey:key];
}



@end
