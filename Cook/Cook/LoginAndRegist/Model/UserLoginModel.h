//
//  UserLoginModel.h
//  Cook
//
//  Created by 叶旺 on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface UserLoginModel : BaseModel

@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *account; //手机号
@property (nonatomic, copy) NSString *profileImageUrl;
@property (nonatomic, copy) NSString *joinDate;
@property (nonatomic, copy) NSString *residence; //所在地
@property (nonatomic, strong) NSNumber *concernCount; //关注
@property (nonatomic, strong) NSNumber *FansCount; //粉丝

@end
