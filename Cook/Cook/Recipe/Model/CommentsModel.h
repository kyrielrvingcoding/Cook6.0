//
//  CommentsModel.h
//  Cook
//
//  Created by 诸超杰 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"
#import "NewUserModel.h"
@interface CommentsModel : BaseModel
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) BOOL isLike;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NewUserModel *UserModel;
@end
