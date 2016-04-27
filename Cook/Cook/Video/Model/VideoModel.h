//
//  VideoModel.h
//  Cooker
//
//  Created by 诸超杰 on 16/4/21.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface VideoModel : BaseModel
@property (nonatomic, copy) NSString *imageid;
@property (nonatomic, copy) NSString *authorname;
@property (nonatomic, copy) NSString *collectCount;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *likeCount;

@property (nonatomic, copy) NSString *authorid;
@property (nonatomic, copy) NSString *authorimageid;
@property (nonatomic, copy) NSString *commentCount;
@end
