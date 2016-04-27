//
//  VideoTableViewCell.h
//  Cooker
//
//  Created by 诸超杰 on 16/4/21.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
@interface VideoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *collectCount;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UIImageView *imageid;
@property (weak, nonatomic) IBOutlet UILabel *name;


- (void)setVideoModel:(VideoModel *)model;
@end
