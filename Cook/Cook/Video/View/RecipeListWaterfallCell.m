//
//  RecipeListWaterfallCell.m
//  Cook
//
//  Created by 叶旺 on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "RecipeListWaterfallCell.h"
#import "RecipeListWaterfallModel.h"

@interface RecipeListWaterfallCell ()

@property (nonatomic, strong) UIImageView *recipeImageView;
@property (nonatomic, strong) UIImageView *authorImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *likeCountLabel;
@property (nonatomic, strong) UILabel *hitscountLabel;

@end

@implementation RecipeListWaterfallCell

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
        [self.contentView addSubview:_recipeImageView];
        [self.contentView addSubview:_authorImageView];
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_likeCountLabel];
        [self.contentView addSubview:_hitscountLabel];
    }
    return self;
}

- (void)setDataWithModel:(RecipeListWaterfallModel *)model {
    [_recipeImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    [_authorImageView sd_setImageWithURL:[NSURL URLWithString:model.referrerModel.profileImageUrl]];
    _nameLabel.text = model.name;
    _likeCountLabel.text = [NSString stringWithFormat:@"点赞 %@", model.likeCount];
    _hitscountLabel.text = [NSString stringWithFormat:@"查看 %@", model.hitscount];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGPoint point = self.bounds.origin;
    CGSize size = self.bounds.size;
    _recipeImageView.frame = CGRectMake(point.x, point.y, size.width, size.height - 80);
    _authorImageView.frame = CGRectMake(size.width / 2 - 20, size.height - 100, 40, 40);
    _nameLabel.frame = CGRectMake(20, size.height - 55, size.width - 40, 21);
    _likeCountLabel.frame = CGRectMake(30, size.height - 25, 90, 16);
    _hitscountLabel.frame = CGRectMake(size.width - 120, size.height - 25, 90, 16);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
