//
//  RecipeDetailHeaderView.h
//  Cooker
//
//  Created by 诸超杰 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
#import "NewRecipeDetailModel.h"
@interface RecipeDetailHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *iconName;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UITableView *materialTabelView;

- (void)setModel:(BaseModel *)model;

- (CGFloat)returnHeightByModel:(BaseModel *)model;

- (void)setNewModel:(NewRecipeDetailModel *)model;
- (CGFloat)newReturnHeightByModel:(NewRecipeDetailModel *)model;
@end
