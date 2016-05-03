//
//  HomeViewController.m
//  Cook
//
//  Created by 诸超杰 on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableView.h"
#import "HomeMoreCookBooksModelCell.h"
#import "HomeMoreCookBooksModel.h"
#import "RecipeListTableViewController.h"
#import "HomeWebViewController.h"
#import "MyselfUserInfoViewController.h"
#import "HomeNewUserModel.h"
#import "LatestDevelopmentViewController.h"
#import "NewRecipeDetailController.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) HomeTableView *hometableView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, assign) CGFloat alpha;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 414, 64)];
//    _backView.backgroundColor = [UIColor redColor];
//    [self.navigationController.navigationBar insertSubview:_backView atIndex:0];
//    NSLog(@"%@", self.navigationController.navigationBar.subviews);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    self.alpha = 0.0; // 初始化透明度
    UIView *backgroundView = [[self.navigationController valueForKey:@"_navigationBar"] valueForKey:@"_backgroundView"];
    backgroundView.backgroundColor = [UIColor whiteColor]; // 颜色自己选
    backgroundView.alpha = self.alpha; // 做渐变最好再设置一下
    self.backView = backgroundView;
    
//    self.navigationController.navigationBar setBackgroundImage:<#(nullable UIImage *)#> forBarMetrics:<#(UIBarMetrics)#>
//    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    self.navigationController.navigationBar.translucent = YES;
    [LoadingDataAnimation startAnimation];
    
     _hometableView = [[HomeTableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    [self.hometableView registerNib:[UINib nibWithNibName:@"HomeMoreCookBooksModelCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
     _hometableView.delegate = self;
     _hometableView.dataSource = self;
    
    [self.view addSubview: _hometableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchButton:) name:@"homeSearchButton" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickCycleScrollView:) name:@"点击轮播图" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfo:) name:@"厨友推荐" object:nil];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(showLatestDevelopment) imageName:@"navigationBar_new" highlightImageName:@"navigationBar_new_h"];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.backView.alpha = 1.0;
}

//点击导航栏右按钮
- (void)showLatestDevelopment {
    LatestDevelopmentViewController *latestVC = [[LatestDevelopmentViewController alloc] init];
    [self.navigationController pushViewController:latestVC animated:YES];
}

//点击菜谱分类button
- (void)searchButton:(NSNotification *)noti {
    UIButton *button = noti.object;
    RecipeListTableViewController *recipeListVC = [[RecipeListTableViewController alloc] init];
    recipeListVC.keyword = button.titleLabel.text;
    [self.navigationController pushViewController:recipeListVC animated:YES];
}

//点击轮播图
- (void)clickCycleScrollView:(NSNotification *)notification {
    NSString *URL = [notification.userInfo objectForKey:@"key"];
    HomeWebViewController *homeWebViewVC = [[ HomeWebViewController alloc] init];
    homeWebViewVC.URL = URL;
    [self.navigationController pushViewController:homeWebViewVC animated:YES];
}

//点击厨友头像
- (void)userInfo:(NSNotification *)notification {
    MyselfUserInfoViewController *myselfUserInfo = [[MyselfUserInfoViewController alloc] init];
     HomeNewUserModel *newUserModel = notification.object;
    myselfUserInfo.ID = newUserModel.ID;
    [self.navigationController pushViewController:myselfUserInfo animated:YES];
}

#pragma mark ------- tableView协议方法 ------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return _hometableView.moreCookbooksArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeMoreCookBooksModelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    HomeMoreCookBooksModel *homeMoreCookBooksModel = _hometableView.moreCookbooksArray[indexPath.row];
    [cell setDataWithModel:homeMoreCookBooksModel];
    cell.selectionStyle = NO;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREENWIDTH * 0.34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewRecipeDetailController *detailVC = [[NewRecipeDetailController alloc] init];
    detailVC.ID = [_hometableView.moreCookbooksArray[indexPath.row] ID];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = _hometableView.contentOffset.y;
    if (offsetY <= SCREENWIDTH * 0.7 && offsetY >= 0) {
        self.alpha = offsetY / (SCREENWIDTH * 0.7 - 64);
        if (_alpha > 1.0) {
            _alpha = 1.0;
        }
//        NSLog(@"%f  %f  %f", offsetY, SCREENWIDTH * 0.7, _alpha);
        self.backView.alpha = self.alpha;
    } else {
        self.backView.alpha = 1.0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 300;
//}



 @end
