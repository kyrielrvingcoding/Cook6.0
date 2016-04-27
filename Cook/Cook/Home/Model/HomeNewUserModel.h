//
//  HomeNewUserModel.h
//  Cook
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface HomeNewUserModel : BaseModel

@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *profileImageUrl;
@property (nonatomic, copy) NSString *signature;

@end
