//
//  MyselfCollectViewController.m
//  Cook
//
//  Created by 叶旺 on 16/4/28.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "MyselfCollectViewController.h"
#import "UserInofManager.h"
#import "MyselfCollectTableViewCell.h"
#import "HomeMoreCookBooksModelCell.h"
#import "HomeMoreCookBooksModel.h"

typedef NS_ENUM(NSInteger, tableViewCellStyle) {
    tableViewCellStyleBig,
    tableViewCellStyleSmall
};
@interface MyselfCollectViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) tableViewCellStyle cellStyle;

@end

@implementation MyselfCollectViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)requestData {
    NSString *sessionID = [UserInofManager getSessionID];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameter = @{@"m":@"mobile", @"c":@"index", @"a":@"getMyCollects", @"sessionId":sessionID};
    [manager GET:@"http://www.xdmeishi.com/index.php" parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *collectArray = dic[@"data"];
        for (NSDictionary *moreCookbooksDic in collectArray) {
            HomeMoreCookBooksModel *moreCookbooksModel = [[HomeMoreCookBooksModel alloc] init];
            [moreCookbooksModel setValuesForKeysWithDictionary:moreCookbooksDic];
            
            NSDictionary * referrerDic = moreCookbooksDic[@"referrer"];
            HomeReferrerModel *referrerModel = [[HomeReferrerModel alloc] init];
            [referrerModel setValuesForKeysWithDictionary:referrerDic];
            
            moreCookbooksModel.referrerModel = referrerModel;
            
            [self.dataArray addObject:moreCookbooksModel];
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
    self.cellStyle = tableViewCellStyleBig;
    [self createTableView];
    [self requestData];
    self.navigationItem.rightBarButtonItem = [self createBarButtonWithImageName:@"rightNavi_bigCell" selectImage:@"rightNavi_smallCell" action:@selector(changeTableViewCellStyle:)];
    // Do any additional setup after loading the view.
}

- (UIBarButtonItem *)createBarButtonWithImageName:(NSString *)string selectImage:(NSString *)selectStr action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:[[UIImage imageNamed:string] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

- (void)changeTableViewCellStyle:(UIButton *)button {
    if (_cellStyle == tableViewCellStyleBig) {
        _cellStyle = tableViewCellStyleSmall;
        [button setImage:[[UIImage imageNamed:@"rightNavi_smallCell"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.tableView reloadData];
    } else {
        _cellStyle = tableViewCellStyleBig;
        [button setImage:[[UIImage imageNamed:@"rightNavi_bigCell"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.tableView reloadData];
    }
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:SCREENBOUNDS style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyselfCollectTableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCellStyleBigBB"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeMoreCookBooksModelCell" bundle:nil] forCellReuseIdentifier:@"TableViewCellStyleSmall"];
}

#pragma mark -----tableView的协议方法-----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_cellStyle == tableViewCellStyleBig) {
        MyselfCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellStyleBigBB" forIndexPath:indexPath];
        [cell setDataWithModel:self.dataArray[indexPath.row]];
        return cell;
    } else {
        HomeMoreCookBooksModelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellStyleSmall" forIndexPath:indexPath];
        [cell setDataWithModel:self.dataArray[indexPath.row]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_cellStyle == tableViewCellStyleBig) {
        return SCREENWIDTH * 0.7;
    } else {
        return SCREENWIDTH * 0.34;
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
