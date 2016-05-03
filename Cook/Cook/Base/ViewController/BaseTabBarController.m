//
//  BaseTabBarController.m
//  Cooker
//
//  Created by 叶旺 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseTabBarController.h"
#import "HomeViewController.h"
#import "RecipeViewController.h"
#import "VideoViewController.h"
#import "MyselfViewController.h"
#import "BaseNavigationViewController.h"


@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

+ (void)initialize {
    UITabBarItem *item = [UITabBarItem appearance];
    //设置选中状态
    NSMutableDictionary *attribute = [NSMutableDictionary dictionaryWithCapacity:0];
    attribute[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:attribute forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    BaseNavigationViewController *homeNaVC = [[BaseNavigationViewController alloc] initWithRootViewController:homeVC];
//    homeNaVC.navigationBar.backgroundColor = [UIColor redColor];
    [self addViewController:homeNaVC title:@"首页" imageName:@"tabBar_home" selectedImageName:@"tabBar_home_h"];
    
    RecipeViewController *recipeVC = [[RecipeViewController alloc] init];
    BaseNavigationViewController *recipeNaVC = [[BaseNavigationViewController alloc] initWithRootViewController:recipeVC];
    [self addViewController:recipeNaVC title:@"菜谱" imageName:@"tabBar_recipe" selectedImageName:@"tabBar_recipe_h"];
    
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    BaseNavigationViewController *videoNaVC = [[BaseNavigationViewController alloc] initWithRootViewController:videoVC];
    [self addViewController:videoNaVC title:@"视频" imageName:@"tabBar_video" selectedImageName:@"tabBar_video_h"];
    
    MyselfViewController *myslefVC = [[MyselfViewController alloc] init];
    BaseNavigationViewController *myslefNaVC = [[BaseNavigationViewController alloc] initWithRootViewController:myslefVC];
    [self addViewController:myslefNaVC title:@"我的" imageName:@"tabBar_myself" selectedImageName:@"tabBar_myself_h"];
    
    
    
    self.viewControllers = @[homeNaVC, recipeNaVC, videoNaVC, myslefNaVC];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addViewController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:controller];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
