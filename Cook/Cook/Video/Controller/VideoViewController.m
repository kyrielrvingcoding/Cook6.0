//
//  VideoViewController.m
//  Cooker
//
//  Created by 诸超杰 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "VideoViewController.h"
#import "RecipeDetailViewController.h"

#import "VideoTableViewCell.h"

#import "VideoModel.h"



@interface VideoViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@end
static NSString *VideoTableViewCellIdentifier  = @"VideoTableViewCellCellIdentifier";
@implementation VideoViewController
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _dataArray;
}


- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 49) style:(UITableViewStylePlain)];
        [_tableView registerNib:[UINib nibWithNibName:@"VideoTableViewCell" bundle:nil] forCellReuseIdentifier:VideoTableViewCellIdentifier];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView ;
}
- (void)requestData {
        NSDictionary *parameter = @{@"version":@"12.2.1.0",@"machine":@"O382baa3c128b3de78ff6bbcd395b2a27194b01ad",@"device":@"iPhone8%2C1"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:RECIPEHOME_URL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        //返回data段
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //正确的
        NSArray *array = responseObject[@"list"];
        NSDictionary *dic = [array lastObject];
        NSArray *ListArray = dic[@"list"];
        NSDictionary *ListDic = [ListArray lastObject];
        NSString *ID = ListDic[@"id"];
        
       NSDictionary *parameter1 = @{@"version":@"12.2.1.0",@"machine":@"O382baa3c128b3de78ff6bbcd395b2a27194b01ad",@"device":@"iPhone8%2C1",@"id":ID};
        [manager POST:SUBCLASS_URL parameters:parameter1 progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *mainArray = responseObject[@"list"];
            for (NSDictionary *mainDic in mainArray) {
                VideoModel *model = [[VideoModel alloc] init];
                [model setValuesForKeysWithDictionary:mainDic];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //错误的方法
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"中华小当家";
    [self requestData];

    
    
}


#pragma mark ======tableView的代理方法=============

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.tableView.frame.size.height / 4.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VideoTableViewCellIdentifier forIndexPath:indexPath];
    [cell setVideoModel:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeDetailViewController *recipeDetailVc = [[RecipeDetailViewController alloc] init];
    VideoModel *model = self.dataArray[indexPath.row];
    recipeDetailVc.ID = model.ID;
    [self.navigationController pushViewController:recipeDetailVc animated:YES];
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
