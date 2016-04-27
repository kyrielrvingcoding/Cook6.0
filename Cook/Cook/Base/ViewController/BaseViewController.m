//
//  BaseViewController.m
//  Cooker
//
//  Created by 诸超杰 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *containerView;


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//创建过渡动画
- (void)createAnimationForTansition {
    
    _containerView = [[UIView alloc] initWithFrame:SCREENBOUNDS];
    _containerView.backgroundColor = [UIColor whiteColor];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(140 , 200, 120,120)];
    [_containerView addSubview:_imageView];
    //设置动画帧
    _imageView.animationImages=[NSArray arrayWithObjects:
                                [UIImage imageNamed:@"1"],
                                [UIImage imageNamed:@"2"],
                                [UIImage imageNamed:@"3"],
                                [UIImage imageNamed:@"4"],
                                [UIImage imageNamed:@"5"],
                                [UIImage imageNamed:@"6"],
                                nil ];
    
    //设置动画总时间
    _imageView.animationDuration= 1;
    //设置重复次数,0表示不重复
    _imageView.animationRepeatCount=0;
    //开始动画
    [_imageView startAnimating];
    
    UILabel *Infolabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 320, SCREENWIDTH, 20)];
    Infolabel.backgroundColor = [UIColor clearColor];
    Infolabel.textAlignment = NSTextAlignmentCenter;
    Infolabel.textColor = [UIColor colorWithRed:84.0/255 green:86./255 blue:212./255 alpha:1];
    Infolabel.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:12.0f];
    Infolabel.text = @"正在努力加载……";
    [_containerView addSubview:Infolabel];
    
    [self.view addSubview:_containerView];
    
    
}
//开始动画
-(void)startAnimation{
    [self createAnimationForTansition];
    [self.view bringSubviewToFront:_containerView];
}
//停止动画
-(void)stopAnimation{
    [_imageView stopAnimating];
    [_containerView removeFromSuperview];
    
}

@end
