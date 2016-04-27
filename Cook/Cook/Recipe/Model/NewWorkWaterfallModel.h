//
//  NewWorkWaterfallModel.h
//  Cook
//
//  Created by 叶旺 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"
#import "RecipeReferrerModel.h"

@interface NewWorkWaterfallModel : BaseModel

@property (nonatomic, copy) NSString *collectCount;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *praiseCount; //随拍点赞数
@property (nonatomic, copy) NSString *commentCount; //评论数
@property (nonatomic, strong) RecipeReferrerModel *userModel;
@property (nonatomic, strong) NSMutableArray *commentArray;

@end
