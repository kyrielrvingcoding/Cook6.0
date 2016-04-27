//
//  StepListModel.h
//  Cooker
//
//  Created by 诸超杰 on 16/4/20.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface StepListModel : BaseModel
@property (nonatomic, copy) NSString *imageid;
@property (nonatomic, copy) NSString *details;//描述
@property (nonatomic, copy) NSNumber *ordernum;//步骤顺序

@end
