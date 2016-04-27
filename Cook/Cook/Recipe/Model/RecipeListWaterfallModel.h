//
//  RecipeListWaterfallModel.h
//  Cook
//
//  Created by 叶旺 on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"
#import "RecipeReferrerModel.h"

@interface RecipeListWaterfallModel : BaseModel

@property (nonatomic, copy) NSString *collectCount;
@property (nonatomic, copy) NSString *hitscount; //查看数
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *likeCount; //点赞数
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *commentCount; //评论数
@property (nonatomic, strong) RecipeReferrerModel *referrerModel;

@end
