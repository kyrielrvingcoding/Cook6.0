//
//  HomeMoreCookBooksModelCell.m
//  Cook
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "HomeMoreCookBooksModelCell.h"
#import "HomeMoreCookBooksModel.h"

@implementation HomeMoreCookBooksModelCell


- (void)setDataWithModel:(HomeMoreCookBooksModel *)model {
    
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    _leftImageView.layer.cornerRadius = 5;
    _leftImageView.layer.masksToBounds = YES;
    self.nameLabel.text = model.name;
    self.nicknameLabel.text = model.referrerModel.nickname;
    self.ingredientsLabel.text = model.ingredients;
    self.hitsCount.text = [NSString stringWithFormat:@"%@次点击",model.hitscount];
    self.commentCount.text = [NSString stringWithFormat:@"%@条评论",model.commentCount ];
    self.collectionCount.text = [NSString stringWithFormat:@"%@个收藏",model.collectCount];
    if (model.likeCount) {
        self.likeCount.text = [NSString stringWithFormat:@"%@个点赞",model.likeCount];
    } else {
        self.likeCount.text = @"0个点赞";
    }
}



@end
