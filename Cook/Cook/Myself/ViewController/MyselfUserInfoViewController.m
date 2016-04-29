//
//  MyselfUserInfoViewController.m
//  Cook
//
//  Created by lanou on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "MyselfUserInfoViewController.h"
#import "MyselfIDModel.h"
#import "MyselfUserInfoModel.h"
#import "HomeMoreCookBooksModelCell.h"
#import "PraiseAndVisitViewController.h"
#import "LatestDevelopmentModel.h"
#import "NewWorkListWaterfallCell.h"
#import "MyselfWorkCell.h"
#import "MyselfWorkModel.h"
#import "MyselfHeaderView.h"
#import "NewRecipeDetailController.h"

@interface MyselfUserInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger index;
}

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MyselfHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *cookbookArray;//菜谱
@property (nonatomic, strong) NSMutableArray *dynamicArray;//动态
@property (nonatomic, strong) NSMutableArray *collectionArray;//收藏
@property (nonatomic, strong) NSMutableArray *workArray;//作品
@property (nonatomic, strong) NSMutableArray *dataArray;//承载

@property (nonatomic, strong) NSMutableArray *userInfoArray;
@property (nonatomic, strong) UIButton *dynamicBtn;
@property (nonatomic, strong) UIButton *cookbookBtn;
@property (nonatomic, strong) UIButton *collectionBtn;
@property (nonatomic, strong) UIButton *workBtn;
@property (nonatomic, strong) UIView *sectionHeaderView;



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

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
            _tableView.dataSource = self;
            _tableView.delegate = self;
            _tableView.tableFooterView = [UIView new];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"HomeMoreCookBooksModelCell" bundle:nil] forCellReuseIdentifier:@"HomeMoreCookBooksModel"];
        [_tableView registerNib:[UINib nibWithNibName:@"LatestDevelopmentModelCell" bundle:nil] forCellReuseIdentifier:@"LatestDevelopmentModel"];
        [_tableView registerNib:[UINib nibWithNibName:@"MyselfWorkCell" bundle:nil] forCellReuseIdentifier:@"MyselfWorkModel"];
//        [_tableView registerNib:[UINib nibWithNibName:@"NewWorkListWaterfallCell" bundle:nil] forCellReuseIdentifier:@"NewWorkWaterfallModel"];

        
    }
    return _tableView;
}

- (void)requestDataWithType:(NSString *)type And:(NSMutableArray *)dataArray And:(NSString *)ModelName{
    NSMutableArray *Array = (NSMutableArray *) dataArray;
    NSDictionary *parameter = @{@"m":@"mobile", @"c":@"index",@"a":type, @"id":_ID,@"sessionId":@"e2ea23a4fe2bd8429326a453476b4f90",@"pageSize":@20,@"pageNum":@1};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   
    [manager GET:@"http://www.xdmeishi.com/index.php" parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *dataArray = dic[@"data"];
        for (NSDictionary *IDDic in dataArray) {
            Class class = NSClassFromString(ModelName);
           id model = [[class alloc] init];
            [model setValuesForKeysWithDictionary:IDDic];
            [Array addObject:model];
        }
        if ([ModelName isEqualToString:@"LatestDevelopmentModel"]) {
            self.dataArray = Array;
            [self.tableView reloadData];
        }

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
        MyselfUserInfoModel *userInfo = [[MyselfUserInfoModel alloc] init];
        [userInfo setValuesForKeysWithDictionary:datadic];
        [self.userInfoArray addObject:userInfo];
        
        [self setDataToHeaderViewWithModel:userInfo];
        

        [self.tableView reloadData];
        [LoadingDataAnimation stopAnimation];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)setDataToHeaderViewWithModel:(MyselfUserInfoModel *)userModel {
    self.navigationItem.title = userModel.nickname;
    _headerView.nicknameLabel.text = userModel.nickname;
    
    [_headerView.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:userModel.profileImageUrl]];
    [_headerView.headerImageview sd_setImageWithURL:[NSURL URLWithString:userModel.profileImageUrl]];
    
    _headerView.jionTimeLabel.text = [_headerView   figuringoutTimesFromNowWith:userModel.joinDate];
    _headerView.addressLabel.text = userModel.residence;
    
    NSString *concernStr = [NSString stringWithFormat:@"%@ 关注", userModel.concernCount];
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc]initWithString:concernStr];
    [string1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, concernStr.length - 2)];
    [string1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, concernStr.length - 2)];
    NSString *fansStr = [NSString stringWithFormat:@"%@ 粉丝", userModel.FansCount];
    _headerView.careLabel.attributedText = string1;
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc]initWithString:fansStr];
    [string2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, fansStr.length - 2)];
    [string2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, fansStr.length - 2)];
    _headerView.fansLabel.attributedText = string2;
}

- (void)createHeaderView {
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"MyselfHeaderView" owner:nil options:nil]lastObject];
    _headerView.headerImageview.layer.cornerRadius = SCREENWIDTH / 10;
    _headerView.headerImageview.layer.masksToBounds = YES;
    [_headerView createBackgroundViewAndHeaderView];
    self.tableView.tableHeaderView = _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self requestData];
    [self requestDataWithType:@"getMyDynamics" And:self.dynamicArray And:NSStringFromClass([LatestDevelopmentModel class])];
    [self requestDataWithType:@"getMyRecipes" And:self.cookbookArray And:NSStringFromClass([HomeMoreCookBooksModel class])];
    [self requestDataWithType:@"getMyCollects" And:self.collectionArray And:NSStringFromClass([HomeMoreCookBooksModel class])];
    index = 0;
    [self requestDataWithType:@"getMyWorks" And:self.workArray And:NSStringFromClass([MyselfWorkModel class])];
    
    [self createHeaderView];
    [LoadingDataAnimation startAnimation];

}


#pragma mark ----- 协议方法 -----
- (UIButton *)createButtonWithButtonNumber:(NSInteger)buttonNumber action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(buttonNumber * SCREENWIDTH / 4, 0, SCREENWIDTH / 4, 40);
//    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    [button setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 10)];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor colorWithRed:164.0 / 255.0 green:212.0/ 255.0 blue:206.0 / 255.0 alpha:1.0]];
    
    return button;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(!_sectionHeaderView) {
   
    _sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    _dynamicBtn = [self createButtonWithButtonNumber:0 action:@selector(dynamicBtn:)];
    _cookbookBtn = [self createButtonWithButtonNumber:1 action:@selector(cookbookBtn:)];
    _collectionBtn = [self createButtonWithButtonNumber:2 action:@selector(collectionBtn:)];
    _workBtn = [self createButtonWithButtonNumber:3 action:@selector(workBtn:)];
    
    [_sectionHeaderView addSubview:_dynamicBtn];
    [_sectionHeaderView addSubview:_cookbookBtn];
    [_sectionHeaderView addSubview:_collectionBtn];
    [_sectionHeaderView addSubview:_workBtn];
   _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 * SCREENWIDTH / 4, 35, SCREENWIDTH / 4, 5)];
    _imageView.backgroundColor = [UIColor orangeColor];
    [_sectionHeaderView addSubview:_imageView];
    }
        
    
    [_dynamicBtn setTitle:@"动态" forState:UIControlStateNormal];
    [_cookbookBtn setTitle:[NSString stringWithFormat:@"%@ 菜谱",[_userInfoArray[0] recipeCount]] forState:UIControlStateNormal];
    [_collectionBtn setTitle:[NSString stringWithFormat:@"%@ 收藏",[_userInfoArray[0] collectCount]] forState:UIControlStateNormal];
    [_workBtn setTitle:[NSString stringWithFormat:@"%@ 作品",[_userInfoArray[0] workCount]] forState:UIControlStateNormal];
    
    return _sectionHeaderView;
    
}


- (void)dynamicBtn:(UIButton *)button {
    
    index = 0;
    [UIView animateWithDuration:0.3 animations:^{
        _imageView.frame = CGRectMake(index *SCREENWIDTH / 4, 35, SCREENWIDTH / 4, 5);
    }];
    self.dataArray = self.dynamicArray;
    [self.tableView reloadData];
    
}
- (void)cookbookBtn:(UIButton *)button {
    index = 1;
    [UIView animateWithDuration:0.3 animations:^{
        _imageView.frame = CGRectMake(index *SCREENWIDTH / 4, 35, SCREENWIDTH / 4, 5);
    }];
    self.dataArray = self.cookbookArray;
    [self.tableView reloadData];
}
- (void)collectionBtn:(UIButton *)button {
    index = 2;
    [UIView animateWithDuration:0.3 animations:^{
        _imageView.frame = CGRectMake(index *SCREENWIDTH / 4, 35, SCREENWIDTH / 4, 5);
    }];
    self.dataArray = self.collectionArray;
    [self.tableView reloadData];
}
- (void)workBtn:(UIButton *)button {
    index = 3;
    [UIView animateWithDuration:0.3 animations:^{
        _imageView.frame = CGRectMake(index *SCREENWIDTH / 4, 35, SCREENWIDTH / 4, 5);
    }];
    self.dataArray = self.workArray;
    [self.tableView reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
     return self.dataArray.count;
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(index == 0){
         return SCREENWIDTH / 2 + 63;
    }else if (index == 1 || index == 2){
        return SCREENHEIGHT * 0.15;
    } else {
        return SCREENWIDTH / 2;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id model = self.dataArray[indexPath.row];
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([model class]) forIndexPath:indexPath];
    [cell setDataWithModel:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewRecipeDetailController *recipeDetailVC =
    [[NewRecipeDetailController alloc] init];
    
    if(index == 0){
        LatestDevelopmentModel *model = self.dataArray[indexPath.row];
         recipeDetailVC.ID = model.operatorModel.ID;
    }else if (index == 1 || index == 2){
       HomeMoreCookBooksModel *model = self.dataArray[indexPath.row];
         recipeDetailVC.ID = model.ID;
    } else {
    MyselfWorkModel
            *model = self.dataArray[indexPath.row];
         recipeDetailVC.ID = model.ID;
    }
    

    [self.navigationController pushViewController:recipeDetailVC animated:YES];
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
