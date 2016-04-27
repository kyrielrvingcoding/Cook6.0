//
//  HomeHeaderView.m
//  Cook
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "HomeHeaderView.h"

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.autoresizesSubviews = YES; // 设置子视图自动调整布局
        [self requestData];
     
        [self createHeaderView];
        
    }
    return self;
}

#pragma mark ------ 懒加载 -----

-(NSMutableArray *)advertsArray {
    if (!_advertsArray) {
        self.advertsArray = [NSMutableArray array];
    }
    return _advertsArray;
}
- (NSMutableArray *)hotCategoriesArray {
    if (!_hotCategoriesArray) {
        self.hotCategoriesArray = [NSMutableArray array];
    }
    return _hotCategoriesArray;
}

#pragma mark ----- 数据请求 -----
- (void)requestData {
    
    NSDictionary *parameters = @{@"m":@"mobile",@"c":@"index",@"a":@"getHomeEntity",@"sessionId":@"f43db4b7e09f0b61717894dd078885d0"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://www.xdmeishi.com/index.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"--------%@", dic);
        NSDictionary *dataDic = dic[@"data"];
        
        // 轮播图
        NSArray *advertsArray = dataDic[@"adverts"];
        for (NSDictionary *advertsDic in advertsArray) {
            HomeAdvertsModel * advertsModel = [[HomeAdvertsModel alloc] init];
            [advertsModel setValuesForKeysWithDictionary:advertsDic];
            if ([advertsModel.url containsString:@"pc_hash=aa0O12"]) {
                [self.advertsArray addObject:advertsModel];
            }
        }
        
        // 类别
        NSArray *hotCategoriesArray = dataDic[@"hotCategories"];
        for (NSDictionary *hotCategoriesdic in hotCategoriesArray) {
            HomeHotCategoriesModel *hotCategoriesModel = [[HomeHotCategoriesModel alloc] init];
            [hotCategoriesModel setValuesForKeysWithDictionary:hotCategoriesdic];
            [self.hotCategoriesArray addObject:hotCategoriesModel];
        }
        [self createCycleScrollView];
        [self createCategoriesButton];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@", error);
    }];
    
}

#pragma mark ---- 创建轮播图 ------
- (void)createCycleScrollView {
    
    _cycleScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width,self.height - 70) animationDuration:2];
    NSMutableArray *viewsArray = [@[] mutableCopy];
    
    for (int i = 0; i < _advertsArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:_cycleScrollView.bounds];
        
        HomeAdvertsModel *model = _advertsArray[i];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        imageView.clipsToBounds = YES;
        [viewsArray addObject:imageView];
    }
    if(viewsArray.count < 2) {
        
        [self addSubview:viewsArray.lastObject];
        
    } else {
        
        [self addSubview:_cycleScrollView];
        
        _cycleScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex) {
            return viewsArray[pageIndex];
        };
        _cycleScrollView.totalPagesCount = viewsArray.count;
        
        
        //  跳转到详情
        __weak NSArray *cycelArray = _advertsArray;
        
        _cycleScrollView.TapActionBlock = ^(NSInteger pageIndex) {
            HomeAdvertsModel * model = [cycelArray objectAtIndex:pageIndex];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"点击轮播图" object:nil userInfo:@{@"key":model.url}];
        };
    }
}

#pragma mark ---- button ---------
- (UIButton *)createButtonWithTitle:(NSString *)title imageName:(NSString *)imageName buttonNumber:(NSInteger)buttonNumber {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(buttonNumber * SCREENWIDTH / 4, self.height-70, SCREENWIDTH / 4, 30);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 10)];

    [button setBackgroundColor:[UIColor colorWithRed:164.0 / 255.0 green:212.0/ 255.0 blue:206.0 / 255.0 alpha:0.7]];

    [self addSubview:button];
    return button;
}

- (void)createCategoriesButton {
    
    for (int i = 0; i < self.hotCategoriesArray.count; i ++) {
     
        HomeHotCategoriesModel *hotCategoriesModel = self.hotCategoriesArray[i];
        UIButton *button = [self createButtonWithTitle:hotCategoriesModel.name imageName:@"tabbar_home" buttonNumber:i];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
   
}

- (void)click:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"homeSearchButton" object:sender];
}

- (void)createHeaderView {
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 ,self.height- 30, 10, 30)];
    leftImageView.backgroundColor = [UIColor orangeColor];
    leftImageView.layer.cornerRadius = 5;
    leftImageView.layer.masksToBounds = YES;
    [self addSubview:leftImageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, self.height- 30, 100, 30)];
    label.text = @"本期推荐";
    [self addSubview:label];
}

@end
