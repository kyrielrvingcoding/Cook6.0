//
//  MyselfViewController.m
//  Cook
//
//  Created by 诸超杰 on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "MyselfViewController.h"
#import "CYloginRegisterViewController.h"
#import "MySelfHeaderView.h"
#import "UserInofManager.h"
#import "PraiseAndVisitViewController.h"
#import "MyselfQuitView.h"
#import "MyselfCollectViewController.h"

@interface MyselfViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) void (^refreshData)();

@end

@implementation MyselfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshLoginMessage) name:@"refreshLoginMessage" object:nil];
}

- (void)refreshLoginMessage {
    _refreshData();
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:SCREENBOUNDS style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_tableView];
    MyselfHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MyselfHeaderView" owner:nil options:nil]lastObject];
    [headerView requestData];
    self.tableView.tableHeaderView = headerView;
    _refreshData = ^{
       [headerView requestData];
    };
    //判断登录状态
    headerView.judgeLoginStatus = ^(UILabel *label) {
        if ([[UserInofManager getSessionID] isEqualToString:@""]) {
            CYloginRegisterViewController *loginVC = [[CYloginRegisterViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
        } else {
            PraiseAndVisitViewController *praiseVC = [[PraiseAndVisitViewController alloc] init];
            if (label.tag == 2000) {
                praiseVC.type = @"1";
                praiseVC.titleName = @"我的关注";
            } else {
                praiseVC.type = @"2";
                praiseVC.titleName = @"我的粉丝";
            }
            [self.navigationController pushViewController:praiseVC animated:YES];
        }
    };
    headerView.judgeLoginOrQuit = ^(UIImageView *imageView) {
        if ([[UserInofManager getSessionID] isEqualToString:@""]) {
            CYloginRegisterViewController *loginVC = [[CYloginRegisterViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
        } else {
            for (UIView *view in self.view.subviews) {
                if ([view isKindOfClass:[MyselfQuitView class]]) {
                    return ;
                }
            }
            MyselfQuitView *imageV = [[MyselfQuitView alloc] initWithFrame:CGRectMake(SCREENWIDTH / 2 - 75, -150, 150, 150)];
            [self.view addSubview:imageV];
            [UIView animateWithDuration:0.3 animations:^{
                imageV.frame = CGRectMake(SCREENWIDTH / 2 - 75, SCREENHEIGHT / 2 - 75, 150, 150);
            }];
        }
    };
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = @[@"我的足迹", @"我的收藏", @"分享应用",@"清除缓存",@"建议、问题反馈",@"关于我们", @"推送通知"];
   static NSString *str = @"myselfViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.textLabel.text = array[indexPath.row];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.imageView.image = [UIImage imageNamed:@"ms_caipu_level_un"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        if (indexPath.row % 2 == 0) {
//             cell.backgroundColor = [UIColor colorWithRed:226 / 255.0 green:233 / 255.0 blue:248/ 255.0 alpha:1.0];
//        } else {
//            cell.backgroundColor = [UIColor colorWithRed:195 / 255.0 green:204 / 255.0 blue:239 / 255.0 alpha:1.0];
//        }
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREENHEIGHT * 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[UserInofManager getSessionID] isEqualToString:@""]) {
        CYloginRegisterViewController *cy = [[CYloginRegisterViewController alloc] initWithNibName:@"CYloginRegisterViewController" bundle:nil];
        [self presentViewController:cy animated:YES completion:nil];
    } else {
        [self clickCellAtIndex:indexPath.row];
    }
}

//点击cell执行
- (void)clickCellAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"111");
            break;
        case 1: {
            MyselfCollectViewController *collectVC = [[MyselfCollectViewController alloc] init];
            [self.navigationController pushViewController:collectVC animated:YES];
            break;
        }
        case 2:
            NSLog(@"333");
            break;
        case 3:
            NSLog(@"444");
            break;
        case 4:
            NSLog(@"555");
            break;
        case 5:
            NSLog(@"666");
            break;
        case 6:
            NSLog(@"777");
            break;
        default:
            break;
    }
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
