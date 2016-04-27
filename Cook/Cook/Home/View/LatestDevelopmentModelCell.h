//
//  LatestDevelopmentModelCell.h
//  Cook
//
//  Created by 叶旺 on 16/4/27.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface LatestDevelopmentModelCell : BaseTableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *operatorImageView;
@property (strong, nonatomic) IBOutlet UILabel *operatorNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *recipeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (strong, nonatomic) IBOutlet UILabel *tagLabel;
@property (strong, nonatomic) IBOutlet UIView *tagView;

@end
