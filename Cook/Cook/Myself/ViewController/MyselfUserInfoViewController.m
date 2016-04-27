//
//  MyselfUserInfoViewController.m
//  Cook
//
//  Created by lanou on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "MyselfUserInfoViewController.h"
#import "MyselfHeaderView.h"
#import "MyselfIDModel.h"

@interface MyselfUserInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MyselfUserInfoViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)requestData {

    NSDictionary *parameter = @{@"m":@"mobile",@"c":@"index",@"a":@"getMyDynamics",@"id":_ID,@"pageNum":@1,@"pageSize":@20};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSDictionary *parameter = @{@"m":@"mobile", @"c":@"index", @"a":@"getUserData"};
    [manager GET:@"http://www.xdmeishi.com/index.php" parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"--------%@", dic);
        NSArray *dataArray = dic[@"data"];
        for (NSDictionary *IDDic in dataArray) {
            MyselfIDModel *model = [[MyselfIDModel alloc] init];
            [model setValuesForKeysWithDictionary:IDDic];
            
            NSDictionary *cookbookDic = IDDic[@"cookbook"];
            HomeMoreCookBooksModel *cookbook = [[HomeMoreCookBooksModel alloc] init];
            [cookbook setValuesForKeysWithDictionary:cookbookDic];
            model.cookbook = cookbook;
            
            
            NSDictionary *operationDic = IDDic[@"operation"];
            HomeNewUserModel *userModel = [[HomeNewUserModel alloc] init];
            [userModel setValuesForKeysWithDictionary:operationDic];
            model.userModel = userModel;
            [self.dataArray addObject:model];
        }
        

        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    [self createTableView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:SCREENBOUNDS style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    MyselfHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MyselfHeaderView" owner:nil options:nil]lastObject];
    self.tableView.tableHeaderView = headerView;
}

#pragma mark ----- 协议方法 -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *str = @"sds";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = @"ew";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREENHEIGHT * 0.1;
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
