//
//  RecipeReferrerModel.h
//  Cook
//
//  Created by 叶旺 on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface RecipeReferrerModel : BaseModel

@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *profileImageUrl;
@property (nonatomic, copy) NSString *gender;

@end
