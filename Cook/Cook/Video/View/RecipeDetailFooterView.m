//
//  RecipeDetailFooterView.m
//  Cooker
//
//  Created by 诸超杰 on 16/4/20.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "RecipeDetailFooterView.h"
@implementation RecipeDetailFooterView


+ (CGFloat)getHeightByRecipeDetailModel:(RecipeDetailModel *)model {

    if (model == nil) {
        return 84;
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
    CGRect rect = [model.tipList boundingRectWithSize:CGSizeMake(SCREENWIDTH * 2.0 / 3.0, 1000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    return rect.size.height  + 84 ;
    
}
@end
