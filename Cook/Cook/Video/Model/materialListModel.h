//
//  materialListModel.h
//  Cooker
//
//  Created by 诸超杰 on 16/4/20.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface materialListModel : BaseModel
@property (nonatomic, copy) NSString *dosage;//数量
@property (nonatomic, copy) NSString *name;//名字
@property (nonatomic, copy) NSNumber *dordernum;//顺序
@end
