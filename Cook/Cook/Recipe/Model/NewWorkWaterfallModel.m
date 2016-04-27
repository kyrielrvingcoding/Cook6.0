//
//  NewWorkWaterfallModel.m
//  Cook
//
//  Created by 叶旺 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "NewWorkWaterfallModel.h"
#import "CommentsModel.h"
@implementation NewWorkWaterfallModel

- (NSMutableArray *)commentArray {
    if (_commentArray == nil) {
        _commentArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _commentArray;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    [super setValue:value forUndefinedKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"comments"]) {
        NSArray *arr = (NSArray *)value;
        NSLog(@"comments");
        if (arr.count == 0) {
            return;
        }
        for (NSDictionary *dic in arr) {
            CommentsModel *model = [[CommentsModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.commentArray addObject:model];
            
        }
        return;
    }
    [super setValue:value forKey:key];
}

@end
