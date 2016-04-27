//
//  RecipeListWaterfallViewController.m
//  Cook
//
//  Created by 叶旺 on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "RecipeListWaterfallViewController.h"
#import "RecipeListWaterfallModel.h"
#import "RecipeListWaterfallCell.h"
#import "RecipeReferrerModel.h"
#import "NewRecipeDetailController.h"
@interface RecipeListWaterfallViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSInteger _pageNum;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation RecipeListWaterfallViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)requestData {
    NSDictionary *parameter = @{@"m":@"mobile", @"c":@"index", @"a":@"getRecipeTheme", @"id":_ID, @"pageNum":@(_pageNum), @"pageSize":@(20),@"sessionId":@"f43db4b7e09f0b61717894dd078885d0"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://www.xdmeishi.com/index.php" parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        NSArray *array = dictionary[@"data"];
        for (NSDictionary *dic in array) {
            NSDictionary *referrerDic = dic[@"referrer"];
            RecipeListWaterfallModel *model = [[RecipeListWaterfallModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            RecipeReferrerModel *referModel = [[RecipeReferrerModel alloc] init];
            [referModel setValuesForKeysWithDictionary:referrerDic];
            model.referrerModel = referModel;
            [self.dataArray addObject:model];
        }
        [self.collectionView reloadData];
        [LoadingDataAnimation stopAnimation];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)requestRefreshData {
    _pageNum = 1;
    [self requestData];
    [self.collectionView.mj_header endRefreshing];
}

- (void)requestMoreData {
    _pageNum ++;
    [self requestData];
    [self.collectionView.mj_footer endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [LoadingDataAnimation startAnimation];
    _pageNum = 1;
    [self createCollectionView];
    [self requestData];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestRefreshData)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    self.collectionView.mj_footer.automaticallyHidden = YES;
    // Do any additional setup after loading the view.
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
//    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[RecipeListWaterfallCell class] forCellWithReuseIdentifier:NSStringFromClass([RecipeListWaterfallModel class])];
}

#pragma mark -------collectionView的协议方法-------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RecipeListWaterfallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RecipeListWaterfallModel class]) forIndexPath:indexPath];
    [cell setDataWithModel:self.dataArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *url = [NSURL URLWithString:[self.dataArray[indexPath.row] imageUrl]];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    NSLog(@"%f------%f", image.size.width, image.size.height);

    NewRecipeDetailController *recipeDetailVC = [[NewRecipeDetailController alloc] init];
    RecipeReferrerModel *referModel = self.dataArray[indexPath.row];
    recipeDetailVC.ID = referModel.ID;
    [self.navigationController pushViewController:recipeDetailVC animated:YES];

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemWidth = (SCREENWIDTH - 15) / 2;
    CGSize itemSize = CGSizeMake(itemWidth, itemWidth + 80);
    return itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
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
