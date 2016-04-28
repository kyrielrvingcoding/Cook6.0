//
//  MyselfCollectTableViewCell.m
//  Cook
//
//  Created by 叶旺 on 16/4/28.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "MyselfCollectTableViewCell.h"
#import "HomeMoreCookBooksModel.h"

@implementation MyselfCollectTableViewCell

- (void)setDataWithModel:(HomeMoreCookBooksModel *)model {
    _likeButton.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectButton.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    _nameLabel.text = model.name;
    _ingredientsLabel.text = model.ingredients;
    _collectCountLabel.text = model.collectCount;
    _commentCountLabel.text = model.commentCount;
    _likeCountLabel.text = model.likeCount;
    _hitscountLabel.text = model.hitscount;
    [_recipeImgView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    [_profileHeaderImgView sd_setImageWithURL:[NSURL URLWithString:model.referrerModel.profileImageUrl]];
    _nickNameLabel.text = model.referrerModel.nickname;
}

//点击喜欢按钮
- (IBAction)clickLikeButton:(UIButton *)sender {
    
}

//点击收藏按钮
- (IBAction)clickCollectBtn:(UIButton *)sender {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
