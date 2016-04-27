//
//  WorksPhotoHeaderView.h
//  Cook
//
//  Created by 诸超杰 on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewWorkWaterfallModel.h"
@interface WorksPhotoHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *worksPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *datelabel;
@property (weak, nonatomic) IBOutlet UIButton *LikeButton;
@property (weak, nonatomic) IBOutlet UILabel *worksNamelabel;


- (void)setNewWorkWaterfallModel:(NewWorkWaterfallModel *)workWaterfallModel;
- (float)getHeightByNewWorkWaterfallModel:(NewWorkWaterfallModel *)workWaterfallModel;

@end
