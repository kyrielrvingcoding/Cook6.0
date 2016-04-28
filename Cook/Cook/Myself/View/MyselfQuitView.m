//
//  MyselfQuitView.m
//  Cook
//
//  Created by 叶旺 on 16/4/27.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "MyselfQuitView.h"
#import "UserInofManager.h"

@implementation MyselfQuitView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"quitLogin_icon"];
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled = YES;
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectView.frame = self.bounds;
        effectView.alpha = 0.7;
        [self addSubview:effectView];
        _quitBtn = [self createButtonWithTitle:@"退  出" imageName:@""  frame:CGRectMake(25, 50, 100, 30) action:@selector(quitLogin)];
        _cancelBtn = [self createButtonWithTitle:@"取  消" imageName:@""  frame:CGRectMake(25, 95, 100, 30) action:@selector(cancel)];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 130, 25)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.text = @"是否确认退出？";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)quitLogin {
    [UserInofManager cancelSessionID];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshLoginMessage" object:nil];
    [self removeFromSuperview];
}

- (void)cancel {
    [self removeFromSuperview];
}

- (UIButton *)createButtonWithTitle:(NSString *)title imageName:(NSString *)imageName frame:(CGRect)frame action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor colorWithRed:164.0 / 255.0 green:212.0/ 255.0 blue:206.0 / 255.0 alpha:0.7]];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [self addSubview:button];
    return button;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
