//
//  RecipeDetailStepCell.h
//  Cooker
//
//  Created by 诸超杰 on 16/4/20.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeDetailModel.h"
#import "NewRecipeDetailModel.h"
@interface RecipeDetailStepCell : UITableViewCell
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UIImageView *picImage;
@property (nonatomic, strong) UILabel *stepLabel;


//进行UI空间赋值的方法
- (void)setModel:(RecipeDetailModel *)model andIndexPath:(NSIndexPath *)indexPath;
//进行UI空间赋值的方法  new
- (void)setNewModel:(NewRecipeDetailModel *)model andIndexpath:(NSIndexPath *)indexPath;

//返回每个分区高度的方法
+ (CGFloat)getHeightWith:(RecipeDetailModel *)model andIndexpath:(NSIndexPath *)indexPath;
//new
+ (CGFloat)getNewHeigjtWith:(NewRecipeDetailModel *)model andIndexPath:(NSIndexPath *)indexPath;
//根据字符多少返会高度
+ (CGFloat)getHeigntWith:(NSString *)string;
@end
