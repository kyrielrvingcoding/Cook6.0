//
//  NewRecipeDetailFootView.h
//  Cook
//
//  Created by 诸超杰 on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewRecipeDetailModel.h"
@interface NewRecipeDetailFootView : UIView


- (void)setNewRecipeDetaileModel:(NewRecipeDetailModel *)model;
- (CGFloat)getHeightByNewRecipeDetaileModel:(NewRecipeDetailModel *)model;


@end
