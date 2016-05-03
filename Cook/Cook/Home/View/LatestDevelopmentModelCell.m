 //
//  LatestDevelopmentModelCell.m
//  Cook
//
//  Created by 叶旺 on 16/4/27.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "LatestDevelopmentModelCell.h"
#import "LatestDevelopmentModel.h"

@interface LatestDevelopmentModelCell ()
@property (nonatomic, strong) NSArray *array;
@end
@implementation LatestDevelopmentModelCell

- (NSArray *)array {
    if (_array == nil) {
        _array = [[NSArray alloc] initWithObjects:@"", @"", @"评论菜谱", @"收藏菜谱", @"发布菜谱", @"", @"", @"称赞菜谱", @"发布作品", @"", @"",nil];
    }
    return _array;
}
- (void)setDataWithModel:(LatestDevelopmentModel *)model {
    [_operatorImageView sd_setImageWithURL:[NSURL URLWithString:model.operatorModel.profileImageUrl]];
    _operatorNameLabel.text = model.operatorModel.nickname;
    _dateLabel.text = [self figuringoutTimesFromNowWith:model.date];
//    if ([model.actionTag isEqualToString:@"8"]) {
//        _tagView.backgroundColor = [UIColor purpleColor];
//        _tagLabel.text = @"发布作品";
//        [_recipeImageView sd_setImageWithURL:[NSURL URLWithString:model.newworkModel.imageUrl]];
//        _recipeLabel.text = model.newworkModel.content;
//    } else if ([model.actionTag isEqualToString:@"4"]) {
//        _tagView.backgroundColor = [UIColor orangeColor];
//        _tagLabel.text = @"发布菜谱";
//        [_recipeImageView sd_setImageWithURL:[NSURL URLWithString:model.recipeModel.imageUrl]];
//        _recipeLabel.text = model.recipeModel.name;
//    } else if ([model.actionTag isEqualToString:@"3"]) {
//        _tagView.backgroundColor = [UIColor orangeColor];
//        _tagLabel.text = @"收藏菜谱";
//        [_recipeImageView sd_setImageWithURL:[NSURL URLWithString:model.recipeModel.imageUrl]];
//        _recipeLabel.text = model.recipeModel.name;
//    } else if [([model.actionTag isEqualToString:<#(nonnull NSString *)#>])
//

    int tag = [model.actionTag intValue];
    _tagLabel.text = self.array[tag];
    _tagView.backgroundColor = [UIColor orangeColor];
    [_recipeImageView sd_setImageWithURL:[NSURL URLWithString:model.recipeModel.imageUrl]];
    NSString *str = model.recipeModel.name;
    switch (tag) {
        case 8:
            [_recipeImageView sd_setImageWithURL:[NSURL URLWithString:model.newworkModel.imageUrl]];
            str = model.newworkModel.content;
            _tagView.backgroundColor = [UIColor purpleColor];
            break;
        case 2:
            str = model.commentContent;
            _tagView.backgroundColor = [UIColor greenColor];
            break;
        case 7:
            str = model.recipeModel.name;
            _tagView.backgroundColor = [UIColor redColor];
            break;
        default:
            break;
    }
    _recipeLabel.text = str;
    
}


- (NSString *)figuringoutTimesFromNowWith:(NSString *)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:time];
    NSDate *nowDate = [NSDate date];
    NSTimeInterval seconds = [nowDate timeIntervalSinceDate:date];
    NSInteger minutes = (NSInteger)seconds / 60;
    NSInteger hours = (NSInteger)minutes / 60;
    NSInteger days = (NSInteger)hours / 24;
    NSString *timeStr = nil;
    if (seconds < 60) {
        timeStr = [NSString stringWithFormat:@"%ld秒前发布", (NSInteger)seconds];
    } else if (minutes < 60) {
        timeStr = [NSString stringWithFormat:@"%ld分钟前发布", minutes];
    } else if (hours < 24) {
        timeStr = [NSString stringWithFormat:@"%ld小时前发布", hours];
    } else {
        timeStr = [NSString stringWithFormat:@"%ld天前发布", days];
    }
    return timeStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
