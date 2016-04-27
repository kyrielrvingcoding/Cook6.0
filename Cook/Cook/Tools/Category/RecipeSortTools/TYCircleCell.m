//
//  TYCircleCell.m
//  TYCircleMenu
//
//  Created by Yeekyo on 16/3/24.
//  Copyright © 2016年 Yeekyo. All rights reserved.
//

#import "TYCircleCell.h"

@implementation TYCircleCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.clipsToBounds = YES;
        [self.contentView addSubview:_bgImageView];
        _imageView = [[UIImageView alloc]initWithFrame:CGRectInset(_bgImageView.frame, 1, 1)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.layer.cornerRadius = CGRectGetMaxX(_imageView.frame) / 2;
//        _imageView.layer.masksToBounds
        [self.contentView addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.height-10, (self.bounds.size.height-20)/2, 70, 20)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _titleLabel.textColor = [UIColor colorWithRed:240 / 255.0 green:160 / 255.0 blue:30 / 255.0 alpha:1.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.layer.anchorPoint = CGPointMake(0.5, 0.5);
        _titleLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}


@end
