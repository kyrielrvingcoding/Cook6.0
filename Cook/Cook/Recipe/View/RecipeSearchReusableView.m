//
//  RecipeSearchReusableView.m
//  Cook
//
//  Created by 叶旺 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "RecipeSearchReusableView.h"

@implementation RecipeSearchReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, width, height)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        
        _markView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 3, height)];
        _markView.backgroundColor = [UIColor orangeColor];
        
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame = CGRectMake(width - 100, 0, 80, 30);
        [_button setTitle:@"清除历史" forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_titleLabel];
        [self addSubview:_markView];
        [self addSubview:_button];
    }
    return self;
}

- (void)clickButton {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"清除历史" object:nil];
}

@end
