//
//  MyselfWorkCell.m
//  Cook
//
//  Created by lanou on 16/4/28.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "MyselfWorkCell.h"
#import "MyselfWorkModel.h"

@implementation MyselfWorkCell

- (void)setDataWithModel:(MyselfWorkModel *)model {
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@", model.content];
    self.commentLabel.text = [NSString stringWithFormat:@"%@", model.commentCount];
    self.likeLabel.text = [NSString stringWithFormat:@"%@", model.praiseCount];
    if (model.isLike) {
        [self.likeBtn setImage:[UIImage imageNamed:@"like_icon_yes"] forState:UIControlStateNormal];
        self.likeBtn.layer.cornerRadius = 25;
        self.likeBtn.layer.masksToBounds = YES;
        
    
       
    }else {
        [self.likeBtn setImage:[UIImage imageNamed:@"like_icon_no"] forState:UIControlStateNormal];
        self.likeBtn.layer.cornerRadius = 20;
        self.likeBtn.layer.masksToBounds = YES;
       
        
    }
    
    [self.commentBtn setImage:[UIImage imageNamed:@"comment_icon_look"] forState:UIControlStateNormal];
    self.commentBtn.layer.cornerRadius = 20;
    self.commentBtn.layer.masksToBounds = YES;
    
  
}



@end
