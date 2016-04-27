//
//  LatestDevelopmentViewController.m
//  Cook
//
//  Created by 叶旺 on 16/4/27.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "LatestDevelopmentViewController.h"
#import "LatestDevelopmentModel.h"
#import "LatestDevelopmentModelCell.h"
#import "NewRecipeDetailController.h"
#import "WorksPhotoController.h"

@interface LatestDevelopmentViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSInteger _pageNum;
    NSInteger _pageSize;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LatestDevelopmentViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)requestData {
    NSDictionary *parameters = @{@"m":@"mobile", @"c":@"index", @"a":@"getConcernDynamics", @"sessionId":@"f43db4b7e09f0b61717894dd078885d0", @"pageNum":@(_pageNum), @"pageSize":@(_pageSize)};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://www.xdmeishi.com/index.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary *dataDic in dic[@"data"]) {
            LatestDevelopmentModel *latestModel = [[LatestDevelopmentModel alloc] init];
            [latestModel setValuesForKeysWithDictionary:dataDic];
            HomeNewUserModel *operatorModel = [[HomeNewUserModel alloc] init];
            [operatorModel setValuesForKeysWithDictionary:dataDic[@"operator"]];
            if ([latestModel.actionTag isEqualToString:@"4"]) {
                RecipeListWaterfallModel *recipeModel = [[RecipeListWaterfallModel alloc] init];
                [recipeModel setValuesForKeysWithDictionary:dataDic[@"cookbook"]];
                latestModel.recipeModel = recipeModel;
            } else if ([latestModel.actionTag isEqualToString:@"8"]) {
                NewWorkWaterfallModel *newworkModel = [[NewWorkWaterfallModel alloc] init];
                [newworkModel setValuesForKeysWithDictionary:dataDic[@"work"]];
                latestModel.newworkModel = newworkModel;
            }
            latestModel.operatorModel = operatorModel;
            [self.dataArray addObject:latestModel];
        }
        [LoadingDataAnimation stopAnimation];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@", error);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [LoadingDataAnimation startAnimation];
    self.navigationItem.title = @"最新动态";
    _pageNum = 1;
    _pageSize = 20;
    [self requestData];
    [self createTableView];
    // Do any additional setup after loading the view.
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:SCREENBOUNDS style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"LatestDevelopmentModelCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([LatestDevelopmentModel class])];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestRefreshData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    self.tableView.mj_footer.automaticallyHidden = YES;
}

- (void)requestRefreshData {
    _pageNum = 1;
    [self requestData];
    [self.tableView.mj_header endRefreshing];
}

- (void)requestMoreData {
    _pageNum ++;
    [self requestData];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark ------tableView的协议方法------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LatestDevelopmentModelCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LatestDevelopmentModel class]) forIndexPath:indexPath];
    [cell setDataWithModel:self.dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREENWIDTH / 2 + 63;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LatestDevelopmentModel *latestModel = self.dataArray[indexPath.row];
    if ([latestModel.actionTag isEqualToString:@"4"]) {
        NewRecipeDetailController *detailVC = [[NewRecipeDetailController alloc] init];
        detailVC.ID = latestModel.recipeModel.ID;
        [self.navigationController pushViewController:detailVC animated:YES];
    } else {
        WorksPhotoController *worksVC = [[WorksPhotoController alloc] init];
        worksVC.WorkWaterfallModel = latestModel.newworkModel;
        [self.navigationController pushViewController:worksVC animated:YES];
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
