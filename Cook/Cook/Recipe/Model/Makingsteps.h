//
//  Makingsteps.h
//  Cook
//
//  Created by 诸超杰 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface Makingsteps : BaseModel
@property (nonatomic, copy) NSString *stepNumber;
@property (nonatomic, copy) NSString *imageUrl ;
@property (nonatomic, assign) BOOL pause;

@end
