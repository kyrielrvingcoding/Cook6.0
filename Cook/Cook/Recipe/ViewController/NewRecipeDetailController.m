//
//  NewRecipeDetailController.m
//  Cook
//
//  Created by 诸超杰 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "NewRecipeDetailController.h"
#import "RecipeDetailViewController.h"
#import "RecipeDetailHeaderView.h"
#import "RecipeDetailFooterView.h"
#import "RecipeDetailStepCell.h"

#import "NewRecipeDetailModel.h"
#import "NewRecipeDetailFootView.h"
static CGFloat kImageHeight = 200;
static NSString *headerReuseIdentifier = @"headerReuseIdentifier";
static NSString *RecipeDetailStepCellReuseIdentifier = @"RecipeDetailStepCell";
@interface NewRecipeDetailController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headerView;//放在tableView上面，用于展示图片
@property (nonatomic, strong) NewRecipeDetailModel *model;
@property (nonatomic, strong) RecipeDetailFooterView *recipeDetailFooterView;
@property (nonatomic, strong) RecipeDetailHeaderView *recipeDetailHeaderView;
@property (nonatomic, strong) NewRecipeDetailFootView *NewrecipeDetailFooterView;
@end

@implementation NewRecipeDetailController
- (UIImageView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIImageView alloc] init];
        _headerView.userInteractionEnabled = YES;
        //把headerView方法tableView的上面
        _headerView.frame = CGRectMake(0, -kImageHeight , SCREENWIDTH, kImageHeight + 35);
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

- (void)requestData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"http://www.xdmeishi.com/index.php?m=mobile&c=index&a=getCookbookDetails&id=%@&sessionId=4adf78c3e1020b97195fdb29b260d1bf",self.ID];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves) error:nil];
        if ([dic[@"result"] isEqualToString:@"ok"]) {
            NSDictionary *dicData = dic[@"data"];
            _model = [[NewRecipeDetailModel alloc] init];
            [_model setValuesForKeysWithDictionary:dicData];
            
            [self.headerView sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl]];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;

    self.tabBarController.tabBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.headerView];

}


//返回头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  [_recipeDetailHeaderView setNewModel:_model];
    
    
    return _recipeDetailHeaderView;
}

//返回头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    RecipeDetailHeaderView *recipeDetailHeaderView = [[NSBundle mainBundle] loadNibNamed:@"RecipeDetailHeaderView" owner:nil options:nil][0];
    _recipeDetailHeaderView = recipeDetailHeaderView;
    CGFloat height = 0;
    if (self.model) {
       height =  [_recipeDetailHeaderView newReturnHeightByModel:_model];
    } else {

    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return _NewrecipeDetailFooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NewRecipeDetailFootView *footView = [[NSBundle mainBundle] loadNibNamed:@"NewRecipeDetailFootView" owner:nil options:nil][0];
    _NewrecipeDetailFooterView = footView;
    return [_NewrecipeDetailFooterView getHeightByNewRecipeDetaileModel:_model];
    
    
}
#pragma mark ------tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.makingStepsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RecipeDetailStepCell getNewHeigjtWith:_model andIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeDetailStepCell *cell = [tableView dequeueReusableCellWithIdentifier:RecipeDetailStepCellReuseIdentifier];
    if (cell == nil) {
        cell = [[RecipeDetailStepCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecipeDetailStepCellReuseIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setNewModel:_model andIndexpath:indexPath];
    return cell;
}







#pragma mark -------------scrollView 代理方法
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
