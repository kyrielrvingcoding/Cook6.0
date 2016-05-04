//
//  PraiseAndVisitViewController.m
//  Cook
//
//  Created by 叶旺 on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "PraiseAndVisitViewController.h"
#import "PraiseAndVisitTableViewCell.h"
#import "HomeNewUserModel.h"
#import "UserInofManager.h"
#import "MyselfUserInfoViewController.h"

@interface PraiseAndVisitViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSInteger _pageNum;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) void (^PraiseOrVisit)(NSString *, BOOL);

@end

@implementation PraiseAndVisitViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)requestData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameter = nil;
    NSString *sessionId = [UserInofManager getSessionID];
    if (self.navigationController.viewControllers.count <= 2) {
        parameter = @{@"m":@"mobile", @"c":@"index", @"a":@"getMyConcerns", @"type":_type, @"pageSize":@(15), @"pageNum":@(_pageNum), @"sessionId":sessionId};
    } else {
        parameter = @{@"m":@"mobile", @"c":@"index", @"a":@"getMyConcerns", @"id":_ID, @"type":_type, @"pageSize":@(15), @"pageNum":@(_pageNum), @"sessionId":sessionId};
    }
    [manager GET:@"http://www.xdmeishi.com/index.php" parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        NSArray *array = dic[@"data"];
        for (NSDictionary *dic in array) {
            HomeNewUserModel *userModel = [[HomeNewUserModel alloc] init];
            [userModel setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:userModel];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
    
    self.PraiseOrVisit = ^(NSString *modelID, BOOL isPraise) {
        if (isPraise) {
            NSDictionary *parameter1 = @{@"m":@"mobile", @"c":@"index", @"a":@"addConcern", @"id":modelID, @"sessionId":sessionId, @"isConcern":@"true"};
            [manager GET:@"http://www.xdmeishi.com/index.php" parameters:parameter1 progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"关注");
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            }];
        } else {
            NSDictionary *parameter1 = @{@"m":@"mobile", @"c":@"index", @"a":@"addConcern", @"id":modelID, @"sessionId":sessionId, @"isConcern":@"false"};
            [manager GET:@"http://www.xdmeishi.com/index.php" parameters:parameter1 progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"取消关注");
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            }];
        }
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNum = 1;
    self.navigationItem.title = _titleName;
    [self createTableView];
    [self requestData];
    // Do any additional setup after loading the view.
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:SCREENBOUNDS style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"PraiseAndVisitTableViewCell" bundle:nil] forCellReuseIdentifier:@"PraiseAndVisitTableViewCell"];
    
    
}

#pragma mark -----tableView协议方法-----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PraiseAndVisitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PraiseAndVisitTableViewCell" forIndexPath:indexPath];
    HomeNewUserModel *userModel = self.dataArray[indexPath.row];
    [cell.concernBtn setTitle:@"关 注" forState:UIControlStateNormal];
    if (_ID == nil) {
        if ([_type isEqualToString:@"1"]) {
            [cell.concernBtn setTitle:@"取消关注" forState:UIControlStateNormal];
            cell.praiseOrVisit = ^{
                _PraiseOrVisit(userModel.ID, NO);
                [self.dataArray removeObject:userModel];
                [self.tableView reloadData];
            };
        } else {
            cell.praiseOrVisit = ^{
                _PraiseOrVisit(userModel.ID, YES);
            };
        }
    } else {
        cell.praiseOrVisit = ^{
            _PraiseOrVisit(userModel.ID, YES);
        };
    }
    [cell setDataWithModel:userModel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyselfUserInfoViewController *userInfoVC = [[MyselfUserInfoViewController alloc] init];
    userInfoVC.ID = [self.dataArray[indexPath.row] ID];
    [self.navigationController pushViewController:userInfoVC animated:YES];
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
