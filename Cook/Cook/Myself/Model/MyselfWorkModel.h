//
//  MyselfWorkModel.h
//  Cook
//
//  Created by lanou on 16/4/28.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"
#import "HomeNewUserModel.h"
#import "CommentsModel.h"
@interface MyselfWorkModel : BaseModel

@property (nonatomic, copy) NSString *recipeName;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *recipeId;
@property (nonatomic, copy) NSString *commentCount;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *praiseCount;
@property (nonatomic, assign) BOOL isLike;

@property (nonatomic, strong) HomeNewUserModel *userModel;
@property (nonatomic, strong) CommentsModel *commentsModel;

@end
