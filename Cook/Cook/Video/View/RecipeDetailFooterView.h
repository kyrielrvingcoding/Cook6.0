//
//  RecipeDetailFooterView.h
//  Cooker
//
//  Created by 诸超杰 on 16/4/20.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeDetailModel.h"

@interface RecipeDetailFooterView : UIView
@property (weak, nonatomic) IBOutlet UILabel *descirbeLabel;
@property (weak, nonatomic) IBOutlet UIButton *otherPerDoButton;


+ (CGFloat)getHeightByRecipeDetailModel:(RecipeDetailModel *)model;
@end
