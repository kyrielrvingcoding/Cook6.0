//
//  RecipeDetailViewController.m
//  Cooker
//
//  Created by 诸超杰 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "RecipeDetailViewController.h"
#import "RecipeDetailHeaderView.h"
#import "RecipeDetailFooterView.h"
#import "RecipeDetailStepCell.h"
#import "RecipeDetailModel.h"
#import "NSURL+AppendingURL.h"
#import "AVPlayerController.h"
#import "AppDelegate.h"
#import "MyselfUserInfoViewController.h"
static CGFloat kImageHeight = 200;
static NSString *headerReuseIdentifier = @"headerReuseIdentifier";
static NSString *RecipeDetailStepCellReuseIdentifier = @"RecipeDetailStepCell";

@interface RecipeDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headerView;//放在tableView上面，用于展示图片
@property (nonatomic, strong) RecipeDetailHeaderView *recipeDetailHeaderView;
@property (nonatomic, strong) RecipeDetailModel *recipeDetailModel;
@property (nonatomic, strong) RecipeDetailFooterView *recipeDetailFooterView;
@end

@implementation RecipeDetailViewController

- (UIImageView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIImageView alloc] init];
        _headerView.userInteractionEnabled = YES;
        //把headerView方法tableView的上面
        _headerView.frame = CGRectMake(0, -kImageHeight , SCREENWIDTH, kImageHeight + 35);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 0, 40, 40);
        CGPoint center = CGPointMake(_headerView.size.width / 2.0, _headerView.frame.size.height / 2.0);
        button.center = center;
        [button setImage:[UIImage imageNamed:@"提示"] forState:UIControlStateNormal];
        [self.headerView addSubview:button];
        [button addTarget:self action:@selector(changeVideoVc) forControlEvents:UIControlEventTouchUpInside];

        _headerView.backgroundColor = [UIColor grayColor];
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 49) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //内容从kImageHeight处开始显示,会在tableView上面kImageHeight位置开始显示
        _tableView.contentInset = UIEdgeInsetsMake(kImageHeight, 0, 0, 0);

    }
    return _tableView;
}

//数据请求
- (void)requestData {
    if (!self.ID) {
        NSLog(@"没有ID数据传入，请求失败");
        return;
    }
     NSDictionary *parameter = @{@"version":@"12.2.1.0",@"machine":@"O382baa3c128b3de78ff6bbcd395b2a27194b01ad",@"device":@"iPhone8%2C1",@"ids":self.ID};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameter1 = @{@"version":@"12.2.1.0",@"machine":@"O382baa3c128b3de78ff6bbcd395b2a27194b01ad",@"device":@"iPhone8%2C1",@"listStr":self.ID};
    //判断是是否是视频
    [manager POST:HASVIDEO_URL parameters:parameter1 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary  *dic = [responseObject[@"list"] lastObject];
        BOOL isVideo = [dic[@"hasVideo"] boolValue];
        if (!isVideo) {
            for (UIView *view in self.headerView.subviews) {
                if ([view isKindOfClass:[UIButton class]]) {
                    view.hidden = YES;
                }
            }
        } else {
            [self getPlayUrl];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    [manager POST:RECIPEDETAIL_URL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        //返回data段
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //正确的
        NSArray *array = responseObject[@"list"];
        NSDictionary *dic = array[0];
        _recipeDetailModel = [[RecipeDetailModel alloc] init];
        [_recipeDetailModel setValuesForKeysWithDictionary:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.headerView sd_setImageWithURL:[NSURL stringAppendingToURLWithString:_recipeDetailModel.imageid]];
            [self.tableView reloadData];
        });
        [LoadingDataAnimation stopAnimation];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //错误的方法
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
    [self requestData];
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.headerView];
    
}
- (void)getPlayUrl {
    NSDictionary *parameter2 = @{@"version":@"12.2.1.0",@"machine":@"O382baa3c128b3de78ff6bbcd395b2a27194b01ad",@"device":@"iPhone8%2C1",@"project":self.ID};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
   [manager POST:GETPLAYURL_URL parameters:parameter2 progress:^(NSProgress * _Nonnull uploadProgress) {
       
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       _recipeDetailModel.playUrl = [NSString stringWithFormat:@"%@%@",responseObject[@"urlprefix"],responseObject[@"name"]];
       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
   }];
}



#pragma mark -------------tableView 代理方法
//返回头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    [_recipeDetailHeaderView setModel:self.recipeDetailModel];
    return _recipeDetailHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    RecipeDetailHeaderView *recipeDetailHeaderView = [[NSBundle mainBundle] loadNibNamed:@"RecipeDetailHeaderView" owner:nil options:nil][0];
    _recipeDetailHeaderView = recipeDetailHeaderView;
    if (self.recipeDetailModel) {
//        NSLog(@"返回头视图高度%f",[_recipeDetailHeaderView returnHeightByModel:self.recipeDetailModel]);
        return [_recipeDetailHeaderView returnHeightByModel:self.recipeDetailModel];//这里返回头的高度
    } else {
        return 0;
    }
    
}


//尾部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    RecipeDetailFooterView *recipeDetailFooterView = [[[NSBundle mainBundle] loadNibNamed:@"RecipeDetailFooterView" owner:nil options:nil] lastObject];
    recipeDetailFooterView.descirbeLabel.text = _recipeDetailModel.tipList;
    _recipeDetailFooterView = recipeDetailFooterView;
    return  _recipeDetailFooterView;
    
}

//尾部视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return  [RecipeDetailFooterView getHeightByRecipeDetailModel:_recipeDetailModel];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recipeDetailModel.stepListModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RecipeDetailStepCell getHeightWith:_recipeDetailModel andIndexpath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeDetailStepCell *cell = [tableView dequeueReusableCellWithIdentifier:RecipeDetailStepCellReuseIdentifier];
    if (cell == nil) {
        cell = [[RecipeDetailStepCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecipeDetailStepCellReuseIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:_recipeDetailModel andIndexPath:indexPath];
    return cell;
    

}

#pragma mark -------------------点击头视图button时，进行跳转
- (void)changeVideoVc {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.is_flip = YES;
    AVPlayerController *avPlayC = [[AVPlayerController alloc] init];
    avPlayC.model = _recipeDetailModel;
    if (!_recipeDetailModel.playUrl) {
        [self getPlayUrl];
        return;
    }
    [self.navigationController presentViewController:avPlayC animated:YES completion:nil];
}

#pragma mark -------------------scrollView 代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //获取滚动视图y值的偏移量
    CGFloat yOffset = scrollView.contentOffset.y;
    //修改x的值
    CGFloat xOffset = (yOffset + kImageHeight) / 2;
//    CGFloat xOffset =  SCREENWIDTH /(kImageHeight + 35) * yOffset;
    if (yOffset < -200) {
        CGRect f = self.headerView.frame;
        f.origin.y = yOffset;
        f.size.height = -yOffset + 35;
        f.origin.x = xOffset;
        f.size.width = SCREENWIDTH + fabs(xOffset) * 2;
        self.headerView.frame = f;

        for (UIView *view in self.headerView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
              CGPoint center = CGPointMake(self.headerView.size.width / 2, f.size.height / 2);
                view.center = center;
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
