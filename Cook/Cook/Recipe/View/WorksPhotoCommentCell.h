//
//  WorksPhotoCommentCell.h
//  Cook
//
//  Created by 诸超杰 on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewWorkWaterfallModel.h"
#import "CommentsModel.h"

@interface WorksPhotoCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *naemLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *datelabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;


+ (CGFloat)getHeightByNewWorkWaterfallModel:(NewWorkWaterfallModel*)model andIndexPath:(NSIndexPath *)indexPath;

- (void)setWithComentsModel:(CommentsModel *)commentsModel;
@end
