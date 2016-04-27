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

@interface PraiseAndVisitViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSInteger _pageNum;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

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
    //www.xdmeishi.com/index.php?m=mobile&c=index&a=getMyConcerns&sessionId=f43db4b7e09f0b61717894dd078885d0&type=1&pageSize=15&pageNum=1
    NSDictionary *parameter = @{@"m":@"mobile", @"c":@"index", @"a":@"getMyConcerns", @"type":_type, @"pageSize":@(15), @"pageNum":@(_pageNum), @"sessionId":@"f43db4b7e09f0b61717894dd078885d0"};
    [manager GET:@"http://www.xdmeishi.com/index.php" parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"--------%@", dic);
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
    if ([_type isEqualToString:@"1"]) {
        [cell.concernBtn setTitle:@"取消关注" forState:UIControlStateNormal];
    } else {
        [cell.concernBtn setTitle:@"关 注" forState:UIControlStateNormal];
    }
    [cell setDataWithModel:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
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
