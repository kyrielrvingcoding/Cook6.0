//
//  IngredientsModel.h
//  Cook
//
//  Created by 诸超杰 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface IngredientsModel : BaseModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, assign) BOOL isMain;
@end
