//
//  LatestDevelopmentModel.h
//  Cook
//
//  Created by 叶旺 on 16/4/27.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"
#import "HomeNewUserModel.h"
#import "RecipeListWaterfallModel.h"
#import "NewWorkWaterfallModel.h"

@interface LatestDevelopmentModel : BaseModel

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *actionTag;
@property (nonatomic, strong) HomeNewUserModel *operatorModel;
@property (nonatomic, strong) RecipeListWaterfallModel *recipeModel;
@property (nonatomic, strong) NewWorkWaterfallModel *newworkModel;

@end
