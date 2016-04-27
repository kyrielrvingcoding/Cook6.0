//
//  NewWorkListWaterfallCell.m
//  Cook
//
//  Created by 叶旺 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "NewWorkListWaterfallCell.h"
#import "NewWorkWaterfallModel.h"

@interface NewWorkListWaterfallCell ()

@property (nonatomic, strong) UIImageView *recipeImageView;
@property (nonatomic, strong) UIImageView *authorImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *likeCountLabel;
@property (nonatomic, strong) UILabel *hitscountLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation NewWorkListWaterfallCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _authorImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _authorImageView.layer.cornerRadius = 20;
        _authorImageView.layer.masksToBounds = YES;
        
        _recipeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _recipeImageView.layer.cornerRadius = 8;
        _recipeImageView.layer.masksToBounds = YES;
        _recipeImageView.contentMode = UIViewContentModeScaleAspectFill;
        _recipeImageView.clipsToBounds = YES;
        _recipeImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        
        _likeCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _likeCountLabel.textColor = [UIColor grayColor];
        _likeCountLabel.font = [UIFont systemFontOfSize:14];
        
        _hitscountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hitscountLabel.textAlignment = NSTextAlignmentRight;
        _hitscountLabel.textColor = [UIColor grayColor];
        _hitscountLabel.font = [UIFont systemFontOfSize:14];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.textColor = [UIColor darkGrayColor];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_recipeImageView];
        [self.contentView addSubview:_authorImageView];
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_likeCountLabel];
        [self.contentView addSubview:_hitscountLabel];
        [self.contentView addSubview:_contentLabel];
    }
    return self;
}

- (void)setDataWithModel:(NewWorkWaterfallModel *)model {
    [_recipeImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    [_authorImageView sd_setImageWithURL:[NSURL URLWithString:model.userModel.profileImageUrl]];
    _nameLabel.text = model.userModel.nickname;
    _contentLabel.text = model.content;
    _likeCountLabel.text = [NSString stringWithFormat:@"点赞 %@", model.praiseCount];
    _hitscountLabel.text = [NSString stringWithFormat:@"评论 %@", model.commentCount];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGPoint point = self.bounds.origin;
    CGSize size = self.bounds.size;
    _recipeImageView.frame = CGRectMake(point.x, point.y, size.width, size.height - 100);
    _authorImageView.frame = CGRectMake(size.width / 2 - 20, size.height - 120, 40, 40);
    _nameLabel.frame = CGRectMake(20, size.height - 75, size.width - 40, 21);
    _contentLabel.frame = CGRectMake(10, size.height - 50, size.width - 20, 18);
    _likeCountLabel.frame = CGRectMake(30, size.height - 24, 90, 16);
    _hitscountLabel.frame = CGRectMake(size.width - 120, size.height - 24, 90, 16);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
