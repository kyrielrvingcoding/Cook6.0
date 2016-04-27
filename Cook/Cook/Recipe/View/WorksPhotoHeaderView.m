//
//  WorksPhotoHeaderView.m
//  Cook
//
//  Created by 诸超杰 on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "WorksPhotoHeaderView.h"

@implementation WorksPhotoHeaderView


- (void)setNewWorkWaterfallModel:(NewWorkWaterfallModel *)workWaterfallModel {
    self.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1];
    [self.worksPhotoImageView sd_setImageWithURL:[NSURL URLWithString:workWaterfallModel.imageUrl]];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:workWaterfallModel.userModel.profileImageUrl]];
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.layer.cornerRadius = 30;
    self.userNameLabel.text = workWaterfallModel.userModel.nickname;
    NSArray *dateArray = [workWaterfallModel.date componentsSeparatedByString:@" "];
    self.datelabel.text = [NSString stringWithFormat:@"发布于 %@",dateArray[0]];
    self.worksNamelabel.text = [NSString stringWithFormat:@"“%@”",workWaterfallModel.content];
}

- (float)getHeightByNewWorkWaterfallModel:(NewWorkWaterfallModel *)workWaterfallModel {
    [self.worksPhotoImageView sd_setImageWithURL:[NSURL URLWithString:workWaterfallModel.imageUrl]];
    UIImage *image = self.worksPhotoImageView.image;
    self.worksPhotoImageView.height = SCREENWIDTH / image.size.width * image.size.height;
    return 600 - 486 + self.worksPhotoImageView.height;
}



@end
