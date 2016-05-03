//
//  RecipeViewController.m
//  Cook
//
//  Created by 诸超杰 on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "RecipeViewController.h"
#import "RecipeCategoryModel.h"
#import "TYCircleCell.h"
#import "TYCircleMenu.h"
#import "RecipeListWaterfallViewController.h"
#import "NewWorkListWaterfallViewController.h"
#import "RecipeSearchCollectionCell.h"
#import "RecipeSearchReusableView.h"
#import "RecipeListTableViewController.h"

#define Home_URL @"http://www.xdmeishi.com/index.php"

@interface RecipeViewController () <TYCircleMenuDelegate, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *categoryArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *searchDataArray;
@property (nonatomic, strong) NSMutableArray *historySearchedArray;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation RecipeViewController

- (NSMutableArray *)categoryArray {
    if (!_categoryArray) {
        self.categoryArray = [NSMutableArray array];
    }
    return _categoryArray;
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        self.imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (NSMutableArray *)searchDataArray {
    if (!_searchDataArray) {
        self.searchDataArray = [NSMutableArray array];
    }
    return _searchDataArray;
}

- (NSMutableArray *)historySearchedArray {
    if (!_historySearchedArray) {
        self.historySearchedArray = [NSMutableArray array];
    }
    return _historySearchedArray;
}

- (void)createModelAddToArrayWithDictionary:(NSDictionary *)dic {
    if (dic == nil) {
        return;
    }
    RecipeCategoryModel *model = [[RecipeCategoryModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    [self.categoryArray addObject:model];
}

- (void)requestData {
    NSDictionary *parameter = @{@"m":@"mobile",@"c":@"index",@"a":@"getHomeEntity",@"sessionId":@"f43db4b7e09f0b61717894dd078885d0"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:Home_URL parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dictionary = [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil] objectForKey:@"data"];
        [self createModelAddToArrayWithDictionary:dictionary[@"mostPopularOfWeek"]]; //本周最热
        [self createModelAddToArrayWithDictionary:dictionary[@"newWorks"]]; //最新作品
        [self createModelAddToArrayWithDictionary:dictionary[@"newCookbook"]]; //最新菜谱
        [self createModelAddToArrayWithDictionary:dictionary[@"newPai"]]; //最新随拍
        [self createModelAddToArrayWithDictionary:dictionary[@"recommend"]]; //家常菜
        [self createModelAddToArrayWithDictionary:dictionary[@"breakfast"]]; //面条
        [self createModelAddToArrayWithDictionary:dictionary[@"lunch"]]; //私房菜
        [self createModelAddToArrayWithDictionary:dictionary[@"dinner"]]; //小吃
        [self createCircleMenu];
        [LoadingDataAnimation stopAnimation];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    NSDictionary *search = @{@"m":@"mobile",@"c":@"index",@"a":@"getRecommendSearchItems",@"sessionId":@"f43db4b7e09f0b61717894dd078885d0"};
    [manager GET:@"http://www.xdmeishi.com/index.php" parameters:search progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array= [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil] objectForKey:@"data"];
        for (NSDictionary *dic in array) {
            [self.searchDataArray addObject:dic[@"name"]];
        }
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:220 / 255.0 green:1.0 blue:156 / 255.0 alpha:1.0]];
    
    self.historySearchedArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"historySearchedArray"] mutableCopy];
    
    [self requestData];
    [self createCollectionView];
    [LoadingDataAnimation startAnimation];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH * 0.8, 30)];
    _searchBar.placeholder = @"食谱、食材搜索";
    _searchBar.delegate = self;
    self.navigationItem.titleView = _searchBar;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearHistorySearchedArray) name:@"清除历史" object:nil];
}

- (void)createCircleMenu {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT - 44)];
    imageView.image = [UIImage imageNamed:@"beijingtupian04"];
    imageView.userInteractionEnabled = YES;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 180)];
    label.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:1.0 blue:156 / 255.0 alpha:1.0];
    [imageView addSubview:label];
    [self.view insertSubview:imageView belowSubview:_collectionView];
    
    NSMutableDictionary *menuDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < _categoryArray.count; i ++) {
        if (![_categoryArray[i] name]) {
            [menuDic setValue:[_categoryArray[i] imageUrl] forKey:[_categoryArray[i] Description]];
        } else {
            [menuDic setValue:[_categoryArray[i] imageUrl] forKey:[_categoryArray[i] name]];
        }
    }
    NSArray *titleArray = [menuDic allKeys];
    for (NSString *key in titleArray) {
        [self.imageArray addObject:menuDic[key]];
    }
    TYCircleMenu *menu = [[TYCircleMenu alloc] initWithRadious:(SCREENWIDTH * 4 / 5) itemOffset:0 imageArray:self.imageArray titleArray:titleArray cycle:YES menuDelegate:self];
    [imageView addSubview:menu];
}

//点击circleCell的方法
- (void)selectMenuAtIndex:(NSInteger)index {
    [_searchBar resignFirstResponder];
    if (index == 2 | index == 6) {
        NewWorkListWaterfallViewController *newworkVC = [[NewWorkListWaterfallViewController alloc] init];
        [self.navigationController pushViewController:newworkVC animated:YES];
    } else {
        RecipeListWaterfallViewController *waterfallVC = [[RecipeListWaterfallViewController alloc] init];
        for (RecipeCategoryModel *model in _categoryArray) {
            if ([model.imageUrl isEqualToString:self.imageArray[index]]) {
                waterfallVC.ID = model.ID;
            }
        }
        [self.navigationController pushViewController:waterfallVC animated:YES];
    }
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.itemSize = CGSizeMake((SCREENWIDTH - 6 * 5) / 5, (SCREENWIDTH - 6 * 5) / 5);
    flowLayout.headerReferenceSize = CGSizeMake(SCREENWIDTH, 25);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 49 - SCREENWIDTH * 2 / 3) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[RecipeSearchCollectionCell class] forCellWithReuseIdentifier:@"RecipeSearch"];
    [_collectionView registerClass:[RecipeSearchReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SearchHeaderView"];
}

#pragma mark ------SearchBar代理方法------
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    RecipeListTableViewController *listVC = [[RecipeListTableViewController alloc] init];
    listVC.keyword = searchBar.text;
    [self.navigationController pushViewController:listVC animated:YES];
    //如果重复搜索直接返回
    if ([self.historySearchedArray containsObject:searchBar.text]) {
        return;
    }
    [self.historySearchedArray addObject:searchBar.text];
    NSArray *searchArr = self.historySearchedArray;
    [[NSUserDefaults standardUserDefaults] setObject:searchArr forKey:@"historySearchedArray"];
    [self.collectionView reloadData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_searchBar resignFirstResponder];
}

#pragma mark ------collectionView的协议方法------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.searchDataArray.count;
    } else {
        return self.historySearchedArray.count;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RecipeSearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecipeSearch" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.nameLabel.text = self.searchDataArray[indexPath.row];
    } else {
        cell.nameLabel.text = self.historySearchedArray[indexPath.row];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    RecipeSearchReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SearchHeaderView" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [headerView.button removeFromSuperview];
        headerView.titleLabel.text = @"热门搜索";
    } else {
        [headerView addSubview:headerView.button];
        headerView.titleLabel.text = @"历史搜索";
    }
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [_searchBar resignFirstResponder];
    RecipeListTableViewController *listVC = [[RecipeListTableViewController alloc] init];
    if (indexPath.section == 0) {
        listVC.keyword = self.searchDataArray[indexPath.row];
    } else {
        listVC.keyword = self.historySearchedArray[indexPath.row];
    }
    [self.navigationController pushViewController:listVC animated:YES];
}

//接收点击历史搜索发送的通知方法
- (void)clearHistorySearchedArray {
    [self.historySearchedArray removeAllObjects];
    NSArray *searchArr = self.historySearchedArray;
    [[NSUserDefaults standardUserDefaults] setObject:searchArr forKey:@"historySearchedArray"];
    [self.collectionView reloadData];
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
