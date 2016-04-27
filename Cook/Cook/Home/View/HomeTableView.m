//
//  HomeTableView.m
//  Cook
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "HomeTableView.h"


@implementation HomeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
//        self.autoresizesSubviews = YES; // 设置子视图自动调整布局
        [self requestData];
        [self createTableView];
    }
    return self;
}

#pragma mark ------ 懒加载 -----
- (NSMutableArray *)moreCookbooksArray {
    if (!_moreCookbooksArray) {
        self.moreCookbooksArray = [NSMutableArray array];
    }
    return _moreCookbooksArray;
}


#pragma mark --- 数据请求 -----
- (void)requestData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://www.xdmeishi.com/index.php?m=mobile&c=index&a=getHomeEntity&sessionId=f43db4b7e09f0b61717894dd078885d0" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dic[@"data"];
        
        // 本期推荐
        NSArray *moreCookbooksArray = dataDic[@"moreCookbooks"];
        for (NSDictionary *moreCookbooksDic in moreCookbooksArray) {
            HomeMoreCookBooksModel *moreCookbooksModel = [[HomeMoreCookBooksModel alloc] init];
            [moreCookbooksModel setValuesForKeysWithDictionary:moreCookbooksDic];
            
            NSDictionary * referrerDic = moreCookbooksDic[@"referrer"];
            HomeReferrerModel *referrerModel = [[HomeReferrerModel alloc] init];
            [referrerModel setValuesForKeysWithDictionary:referrerDic];
            
            moreCookbooksModel.referrerModel = referrerModel;
            
            [self.moreCookbooksArray addObject:moreCookbooksModel];
        }
        [LoadingDataAnimation stopAnimation];
        [self reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@", error);
    }];
    
}

#pragma mark ---- 创建TableView ------
- (void)createTableView {
    
    HomeHeaderView *homeHeaderView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH,SCREENWIDTH * 0.7)];
    self.tableHeaderView = homeHeaderView;
   
    
    HomeFooterView *homeFooterView = [[HomeFooterView alloc] initWithFrame: CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH * 0.5)];
    
    
    self.tableFooterView = homeFooterView;
    
    
}


@end
