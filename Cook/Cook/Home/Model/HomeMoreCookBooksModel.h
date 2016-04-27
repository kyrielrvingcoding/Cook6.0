//
//  HomeMoreCookBooksModel.h
//  Cook
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"
#import "HomeReferrerModel.h"

@interface HomeMoreCookBooksModel : BaseModel
@property (nonatomic, copy) NSString *commentCount;
@property (nonatomic, copy) NSString *hitscount;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *ingredients;
@property (nonatomic, assign) BOOL isCollect;
@property (nonatomic, assign) BOOL isConcern;
@property (nonatomic, assign) BOOL isLike;
@property (nonatomic, copy) NSString *likeCount;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *recommend;
@property (nonatomic, copy) NSString *collectCount;
@property (nonatomic, copy) NSString *uploadDate;


@property (nonatomic, strong) HomeReferrerModel *referrerModel;

@end
