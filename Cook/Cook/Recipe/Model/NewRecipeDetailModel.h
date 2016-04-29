//
//  NewRecipeDetailModel.h
//  Cook
//
//  Created by 诸超杰 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"
#import "IngredientsModel.h"
#import "Makingsteps.h"
#import "CommentsModel.h"
#import "NewUserModel.h"
@interface NewRecipeDetailModel : BaseModel

@property (nonatomic, copy) NSString *shareId;
@property (nonatomic, copy) NSNumber *workCount;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *lastModifyDate;
@property (nonatomic, copy) NSString *uploadDate;
@property (nonatomic, copy) NSNumber *commentCount;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *taste;
@property (nonatomic, copy) NSString *cookimgWay;
@property (nonatomic, copy) NSString *difficulty;
@property (nonatomic, copy) NSString *times;
@property (nonatomic, copy) NSNumber *hitsCount;
@property (nonatomic, copy) NSNumber *likeCount;
@property (nonatomic, copy) NSNumber *collectCount;
@property (nonatomic, copy) NSString *warmTip;//小贴士
@property (nonatomic, assign) BOOL isCollect;
@property (nonatomic, assign) BOOL isLike;
@property (nonatomic, assign) BOOL isConcern;

@property (nonatomic, strong) NewUserModel *userModel;
@property (nonatomic, strong) NSMutableArray *ingredientsArray;//材料
@property (nonatomic, strong) NSMutableArray *makingStepsArray;//步骤
@property (nonatomic, strong) NSMutableArray *commentsArray;//评论


@end
