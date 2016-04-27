//
//  BaseModel.m
//  Cooker
//
//  Created by 诸超杰 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([@"id" isEqualToString:key]) {
        self.ID = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([@"desciption" isEqualToString:key]) {
        self.Description = value;
    }
}
@end
