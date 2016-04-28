//
//  MyselfCollectTableViewCell.h
//  Cook
//
//  Created by 叶旺 on 16/4/28.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MyselfCollectTableViewCell : BaseTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ingredientsLabel;
@property (strong, nonatomic) IBOutlet UILabel *collectCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *hitscountLabel;
@property (strong, nonatomic) IBOutlet UIImageView *recipeImgView;
@property (strong, nonatomic) IBOutlet UIImageView *profileHeaderImgView;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@end
