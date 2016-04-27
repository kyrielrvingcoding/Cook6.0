//
//  RecipeCategoryModel.h
//  Cook
//
//  Created by 叶旺 on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface RecipeCategoryModel : BaseModel

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *skip;
@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSArray *imageUrls;

@end
