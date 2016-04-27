//
//  NewRecipeDetailStepCell.h
//  Cook
//
//  Created by 诸超杰 on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewRecipeDetailStepCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *LikeButton;
@property (weak, nonatomic) IBOutlet UILabel *DescriptionLabel;


@end
