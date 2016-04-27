//
//  WorksPhotoCommentCell.m
//  Cook
//
//  Created by 诸超杰 on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "WorksPhotoCommentCell.h"
@implementation WorksPhotoCommentCell

+ (CGFloat)getHeightByNewWorkWaterfallModel:(NewWorkWaterfallModel*)model andIndexPath:(NSIndexPath *)indexPath{
//    92 - 20 +
//
//    SCREENWIDTH - 108
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName ,nil];
    CommentsModel *commentModel = model.commentArray[indexPath.row];
    CGRect rect = [commentModel.content boundingRectWithSize:CGSizeMake(SCREENWIDTH - 108, 1000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    CGFloat height = rect.size.height + 90 - 20;
    return height;
}

- (void)setWithComentsModel:(CommentsModel *)commentsModel {
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:commentsModel.UserModel.profileImageUrl]];
    self.naemLabel.text = commentsModel.UserModel.nickname;
    self.datelabel.text = commentsModel.date;
    self.commentLabel.text = commentsModel.content;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
