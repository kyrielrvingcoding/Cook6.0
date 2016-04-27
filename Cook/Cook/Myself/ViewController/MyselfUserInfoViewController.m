//
//  MyselfUserInfoViewController.m
//  Cook
//
//  Created by lanou on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "MyselfUserInfoViewController.h"
#import "MyselfUserInfoHeaderView.h"
#import "MyselfIDModel.h"
#import "MyselfUserInfoModel.h"
#import "HomeMoreCookBooksModelCell.h"
#import "PraiseAndVisitViewController.h"


@interface MyselfUserInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger index;
}

@property (nonatomic, copy) UIScrollView *rootScrollView;
@property (nonatomic, strong) UITableView *cookbookTableView;
@property (nonatomic, strong) UITableView *collectTableView;
@property (nonatomic, strong) UITableView *workTableView;
@property (nonatomic, strong) UITableView *dynamicTableView;

@property (nonatomic, strong) NSMutableArray *cookbookArray;
@property (nonatomic, strong) NSMutableArray *dynamicArray;
@property (nonatomic, strong) NSMutableArray *collectionArray;
@property (nonatomic, strong) NSMutableArray *workArray;

@property (nonatomic, strong) NSMutableArray *userInfoArray;
@property (nonatomic, strong)  MyselfUserInfoModel *userInfo;
@property (nonatomic, strong) UIButton *dynamicBtn;
@property (nonatomic, strong) UIButton *cookbookBtn;
@property (nonatomic, strong) UIButton *collectionBtn;
@property (nonatomic, strong) UIButton *workBtn;




@property (nonatomic, strong) MyselfUserInfoHeaderView *headerView;


@end

@implementation MyselfUserInfoViewController

- (NSMutableArray *)dynamicArray {
    if (!_dynamicArray) {
        self.dynamicArray = [NSMutableArray array];
    }
    return _dynamicArray;
}

- (NSMutableArray *)collectionArray {
    if (!_collectionArray) {
        self.collectionArray = [NSMutableArray array];
    }
    return _collectionArray;
}

- (NSMutableArray *)workArray {
    if (!_workArray) {
        self.workArray = [NSMutableArray array];
    }
    return _workArray;
}

- (NSMutableArray *)cookbookArray {
    if (!_cookbookArray) {
        self.cookbookArray = [NSMutableArray array];
    }
    return _cookbookArray;
}

- (NSMutableArray *)userInfoArray {
    if (!_userInfoArray) {
        self.userInfoArray = [NSMutableArray array];
    }
    return _userInfoArray;
}

- (void)requestDataWithType:(NSString *)type {
    
    NSDictionary *parameter = @{@"m":@"mobile", @"c":@"index",@"a":type, @"id":_ID,@"sessionId":@"e2ea23a4fe2bd8429326a453476b4f90",@"pageSize":@20,@"pageNum":@1};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   
    [manager GET:@"http://www.xdmeishi.com/index.php" parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *dataArray = dic[@"data"];
        for (NSDictionary *IDDic in dataArray) {
            MyselfIDModel *model = [[MyselfIDModel alloc] init];
            [model setValuesForKeysWithDictionary:IDDic];
            
            NSDictionary *cookbookDic = IDDic[@"cookbook"];
            HomeMoreCookBooksModel *cookbook = [[HomeMoreCookBooksModel alloc] init];
            [cookbook setValuesForKeysWithDictionary:cookbookDic];
            model.cookbook = cookbook;
            [self.cookbookArray addObject: cookbook];
            
            NSDictionary *operationDic = IDDic[@"operation"];
            HomeNewUserModel *userModel = [[HomeNewUserModel alloc] init];
            [userModel setValuesForKeysWithDictionary:operationDic];
            model.userModel = userModel;
            [self.cookbookArray addObject:model];
        }
        
//        [self.collectTableView reloadData];
        [self.dynamicTableView reloadData];
//        [self.collectTableView reloadData];
//        [self.collectTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
    


}

- (void)requestData {
    
    NSDictionary *parameter1 = @{@"m":@"mobile",@"c":@"index",@"a":@"getUserPublicInfo",@"id":_ID,@"sessionId":@"e2ea23a4fe2bd8429326a453476b4f90"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:@"http://www.xdmeishi.com/index.php" parameters:parameter1 progress:^(NSProgress * _Nonnull downloadProgress) {
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *datadic = dic[@"data"];
        _userInfo = [[MyselfUserInfoModel alloc] init];
        [_userInfo setValuesForKeysWithDictionary:datadic];
        [self.userInfoArray addObject:_userInfo];
        
        
        MyselfUserInfoHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MyselfUserInfoHeaderView" owner:nil options:nil]lastObject];
        [headerView setDataWithModel:_userInfo];
        _dynamicTableView.tableHeaderView = headerView;
//        _collectTableView.tableHeaderView = headerView;
//        _cookbookTableView.tableHeaderView = headerView;
//        _workTableView.tableHeaderView = headerView;
        [self.dynamicTableView reloadData];
//        [self.collectTableView reloadData];
//        [self.cookbookTableView reloadData];
//        [self.workTableView reloadData];
        [self createTableViewWithOffestWithScreenWidth:index];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    index = 0;
    [self createScrollView];
    
    [self requestDataWithType:@"getMyDynamics"];
    [self requestData];

    [_cookbookTableView registerNib:[UINib nibWithNibName:@"HomeMoreCookBooksModelCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (void)createScrollView {
    
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    _rootScrollView.contentSize = CGSizeMake(SCREENWIDTH * 4, SCREENHEIGHT );
    _rootScrollView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:_rootScrollView];
}

- (void)createTableViewWithOffestWithScreenWidth:(NSInteger)numberIndex {
    numberIndex = index;
    _dynamicTableView = [[UITableView alloc] initWithFrame:CGRectMake(numberIndex * SCREENWIDTH,0 , SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
    _dynamicTableView.dataSource = self;
    _dynamicTableView.delegate = self;
    _dynamicTableView.tableFooterView = [UIView new];
    [_rootScrollView addSubview:_dynamicTableView];
    
    MyselfUserInfoHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MyselfUserInfoHeaderView" owner:nil options:nil]lastObject];
    [headerView setDataWithModel:_userInfo];
    _dynamicTableView.tableHeaderView = headerView;

    
//    _collectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1 * SCREENWIDTH, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
//    _collectTableView.dataSource = self;
//    _collectTableView.delegate = self;
//    _collectTableView.tableFooterView = [UIView new];
//    [_rootScrollView addSubview:_collectTableView];
//    _cookbookTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 2 * SCREENWIDTH, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
//    _cookbookTableView.dataSource = self;
//    _cookbookTableView.delegate = self;
//    _cookbookTableView.tableFooterView = [UIView new];
//    [_rootScrollView addSubview:_cookbookTableView];
//    
//    _workTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 3 * SCREENWIDTH, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
//    _workTableView.dataSource = self;
//    _workTableView.delegate = self;
//    _workTableView.tableFooterView = [UIView new];
//    [_rootScrollView addSubview:_workTableView];
    

}

#pragma mark ----- 协议方法 -----
- (UIButton *)createButtonWithTitle:(NSString *)title imageName:(NSString *)imageName buttonNumber:(NSInteger)buttonNumber action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(buttonNumber * SCREENWIDTH / 4, 0, SCREENWIDTH / 4, 40);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 10)];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor colorWithRed:164.0 / 255.0 green:212.0/ 255.0 blue:206.0 / 255.0 alpha:0.7]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(buttonNumber * SCREENWIDTH / 4, 35, SCREENWIDTH / 4, 5)];
    imageView.backgroundColor = [UIColor orangeColor];
    [button addSubview:imageView];
    return button;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    _dynamicBtn = [self createButtonWithTitle:@"动态" imageName:nil buttonNumber:0 action:@selector(dynamicBtn:)];
    _cookbookBtn = [self createButtonWithTitle:[NSString stringWithFormat:@"%@菜谱",[_userInfoArray[0] recipeCount]] imageName:nil buttonNumber:1 action:@selector(cookbookBtn:)];
    _collectionBtn = [self createButtonWithTitle:[NSString stringWithFormat:@"%@收藏",[_userInfoArray[0] collectCount]] imageName:nil buttonNumber:2 action:@selector(collectionBtn:)];
    _workBtn = [self createButtonWithTitle:[NSString stringWithFormat:@"%@作品",[_userInfoArray[0] workCount]] imageName:nil buttonNumber:3 action:@selector(workBtn:)];
    [view addSubview:_dynamicBtn];
    [view addSubview:_cookbookBtn];
    [view addSubview:_collectionBtn];
    [view addSubview:_workBtn];
    
    return view;
}

- (void)dynamicBtn:(UIButton *)button {
    [self createTableViewWithOffestWithScreenWidth:0];
    [self requestDataWithType:@"getMyDynamics"];
    
}
- (void)cookbookBtn:(UIButton *)button {
    [self createTableViewWithOffestWithScreenWidth:1];
    [self requestDataWithType:@"getMyRecipes"];
}
- (void)collectionBtn:(UIButton *)button {
    [self createTableViewWithOffestWithScreenWidth:2];
    [self requestDataWithType: @"getMyCollects"];
}
- (void)workBtn:(UIButton *)button {
    [self createTableViewWithOffestWithScreenWidth:3];
    [self requestDataWithType:@"getMyWorks"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
     return self.cookbookArray.count;
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeMoreCookBooksModelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    HomeMoreCookBooksModel *cookModel = self.cookbookArray[indexPath.row];
    [cell setDataWithModel:cookModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREENHEIGHT * 0.15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
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
