//
//  MselfIDModel.h
//  Cook
//
//  Created by lanou on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"
#import "HomeNewUserModel.h"
#import "HomeMoreCookBooksModel.h"

@interface MyselfIDModel : BaseModel

@property (nonatomic, copy) NSString *commentContent;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *actionTag;
@property (nonatomic, copy) NSString *work;

@property (nonatomic, strong) HomeNewUserModel *userModel;
@property (nonatomic, strong) HomeMoreCookBooksModel *cookbook;

@end
