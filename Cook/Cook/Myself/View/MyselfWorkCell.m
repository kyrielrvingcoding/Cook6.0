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
  
}



@end
