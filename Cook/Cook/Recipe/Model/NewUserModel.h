//
//  NewUserModel.h
//  Cook
//
//  Created by 诸超杰 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface NewUserModel : BaseModel
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *profileImageUrl;
@end