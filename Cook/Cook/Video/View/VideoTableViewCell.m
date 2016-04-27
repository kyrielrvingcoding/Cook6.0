//
//  VideoTableViewCell.m
//  Cooker
//
//  Created by 诸超杰 on 16/4/21.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "NSURL+AppendingURL.h"
@implementation VideoTableViewCell

- (void)setVideoModel:(VideoModel *)model {
    [self.imageid sd_setImageWithURL:[NSURL stringAppendingToURLWithString:model.imageid]];
    self.descriptionLabel.text = model.Description;
    self.likeCount.text = [NSString stringWithFormat:@"喜欢  %@",model.likeCount];
    self.collectCount.text = [NSString stringWithFormat:@"收藏 %@",model.collectCount];
    self.name.text = model.name;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
