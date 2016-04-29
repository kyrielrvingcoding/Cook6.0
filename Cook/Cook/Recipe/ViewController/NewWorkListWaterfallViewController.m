//
//  NewWorkListWaterfallViewController.m
//  Cook
//
//  Created by 叶旺 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "NewWorkListWaterfallViewController.h"
#import "NewWorkWaterfallModel.h"
#import "RecipeWaterfallFlowLayout.h"
#import "NewWorkListWaterfallCell.h"
#import "WorksPhotoController.h"
@interface NewWorkListWaterfallViewController () <UICollectionViewDelegate, UICollectionViewDataSource, WaterFlowLayoutDelegate>
{
    NSInteger _pageNum;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation NewWorkListWaterfallViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)requestData {
    NSDictionary *parameter = @{@"m":@"mobile", @"c":@"index", @"a":@"getNewWork", @"pageNum":@(_pageNum), @"pageSize":@(20),@"sessionId":@"f43db4b7e09f0b61717894dd078885d0"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://www.xdmeishi.com/index.php" parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        NSArray *array = dictionary[@"data"];
        for (NSDictionary *dic in array) {
            NSDictionary *referrerDic = dic[@"user"];
            NewWorkWaterfallModel *model = [[NewWorkWaterfallModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            RecipeReferrerModel *referModel = [[RecipeReferrerModel alloc] init];
            [referModel setValuesForKeysWithDictionary:referrerDic];
            model.userModel = referModel;
            [self.dataArray addObject:model];
        }
        [self.collectionView reloadData];
        if (array.count == 0) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.collectionView.mj_footer endRefreshing];
        }
        [LoadingDataAnimation stopAnimation];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)requestMoreData {
    _pageNum ++;
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [LoadingDataAnimation startAnimation];
    _pageNum = 1;
    [self createCollectionView];
    [self requestData];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    self.collectionView.mj_footer.automaticallyHidden = YES;
    // Do any additional setup after loading the view.
}

- (void)createCollectionView {
    RecipeWaterfallFlowLayout *waterFlowLayout = [[RecipeWaterfallFlowLayout alloc] init];
    waterFlowLayout.numberOfColumn = 2;
    waterFlowLayout.delegate = self;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:waterFlowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[NewWorkListWaterfallCell class] forCellWithReuseIdentifier:NSStringFromClass([NewWorkWaterfallModel class])];
}

#pragma mark -------collectionView的协议方法-------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewWorkListWaterfallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NewWorkWaterfallModel class]) forIndexPath:indexPath];
    [cell setDataWithModel:self.dataArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WorksPhotoController *worksPhotoC = [[WorksPhotoController alloc] init];
    worksPhotoC.WorkWaterfallModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:worksPhotoC animated:YES];
    
}

#pragma mark ------RecipeWaterfallFlowLayout协议方法------
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(RecipeWaterfallFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger random = arc4random() % (7 - 4 + 1) + 4;
    CGFloat itemWidth = (SCREENWIDTH - 15) / 2;
    CGSize itemSize = CGSizeMake(itemWidth, itemWidth * random / 5.0 + 100);
    return itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(RecipeWaterfallFlowLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(RecipeWaterfallFlowLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(RecipeWaterfallFlowLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
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
