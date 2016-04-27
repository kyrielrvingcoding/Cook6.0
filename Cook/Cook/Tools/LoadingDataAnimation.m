//
//  LoadingDataAnimation.m
//  Cooker
//
//  Created by 叶旺 on 16/4/22.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "LoadingDataAnimation.h"

@interface LoadingDataAnimation ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *containerView;

@end

@implementation LoadingDataAnimation

+ (instancetype)defautManager {
    static LoadingDataAnimation *animation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animation = [[LoadingDataAnimation alloc] init];
    });
    return animation;
}

//创建过渡动画
- (void)createAnimationForTransition {
    
    _containerView = [[UIView alloc] initWithFrame:SCREENBOUNDS];
    _containerView.backgroundColor = [UIColor whiteColor];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.38 , SCREENHEIGHT / 2 - SCREENWIDTH * 0.12, SCREENWIDTH * 0.24, SCREENWIDTH * 0.24)];
    [_containerView addSubview:_imageView];
    //设置动画帧
    _imageView.animationImages=[NSArray arrayWithObjects:
                                [UIImage imageNamed:@"1"], [UIImage imageNamed:@"2"],
                                [UIImage imageNamed:@"3"], [UIImage imageNamed:@"4"],
                                [UIImage imageNamed:@"5"], [UIImage imageNamed:@"6"], nil];
    
    //设置动画总时间
    _imageView.animationDuration = 1;
    //设置重复次数,0表示不重复
    _imageView.animationRepeatCount=0;
    //开始动画
    [_imageView startAnimating];
    
    UILabel *Infolabel = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT / 2 + SCREENWIDTH * 0.12, SCREENWIDTH, 20)];
    Infolabel.backgroundColor = [UIColor clearColor];
    Infolabel.textAlignment = NSTextAlignmentCenter;
    Infolabel.textColor = [UIColor colorWithRed:84.0 / 255 green:86.0 / 255 blue:212.0 / 255 alpha:1];
    Infolabel.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:12.0f];
    Infolabel.text = @"正在努力加载中……";
    [_containerView addSubview:Infolabel];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:_containerView];
}

+ (void)startAnimation {
    LoadingDataAnimation *animation = [LoadingDataAnimation defautManager];
    [animation createAnimationForTransition];
}

//延迟停止动画
+ (void)stopAnimation{
    LoadingDataAnimation *animation = [LoadingDataAnimation defautManager];
    [animation stopAnimationAfterOneSeconds];
}

- (void)stopAnimationAfterOneSeconds {
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(endedAnimation) userInfo:nil repeats:NO];
}

- (void)endedAnimation {
    [_containerView removeFromSuperview];
}


@end
