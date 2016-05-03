//
//  BaseNavigationViewController.m
//  Cooker
//
//  Created by 叶旺 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

+ (void)initialize {
    //设置整个项目所有item的主题颜色
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //设置普通状态
    NSMutableDictionary *attribute = [NSMutableDictionary dictionaryWithCapacity:0];
    attribute[NSForegroundColorAttributeName] = [UIColor grayColor];
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:attribute forState:UIControlStateNormal];
    //设置高亮状态
    NSMutableDictionary *highlightAttribute = [NSMutableDictionary dictionaryWithCapacity:0];
    highlightAttribute[NSForegroundColorAttributeName] = [UIColor orangeColor];
    highlightAttribute[NSFontAttributeName] = [UIFont boldSystemFontOfSize:15];
    [item setTitleTextAttributes:highlightAttribute forState:UIControlStateHighlighted];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"navigationbar_back" highlightImageName:@"navigationbar_back_h"];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
