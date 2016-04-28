//
//  HomeFooterView.m
//  Cook
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "HomeFooterView.h"
#import "HomeNewUserModel.h"


@interface HomeFooterView ()

@property (strong, nonatomic) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *newuserArray;//厨友数据源

@end


@implementation HomeFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self requestData];
        [self createHeaderView];
        
    }
    return self;
}

- (NSMutableArray *)newuserArray {
    if (!_newuserArray) {
        self.newuserArray = [NSMutableArray array];
    }
    return _newuserArray;
}
#pragma mark --- 数据请求 -----
- (void)requestData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://www.xdmeishi.com/index.php?m=mobile&c=index&a=getHomeEntity&sessionId=f43db4b7e09f0b61717894dd078885d0" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //        NSLog(@"--------%@", dic);
        NSDictionary *dataDic = dic[@"data"];
        
        //推荐厨友
        NSArray *newUserArray = dataDic[@"newUser"];
        for (NSDictionary *newUserDic in newUserArray) {
            HomeNewUserModel *newUserModel = [[HomeNewUserModel alloc] init];
            [newUserModel setValuesForKeysWithDictionary:newUserDic];
            [self.newuserArray addObject:newUserModel];
        }
     [self createScrollView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@", error);
    }];
    
}

- (void)createHeaderView {
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 ,5, 10, 30)];
    leftImageView.backgroundColor = [UIColor orangeColor];
    leftImageView.layer.cornerRadius = 5;
    leftImageView.layer.masksToBounds = YES;
    [self addSubview:leftImageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 100, 30)];
    label.text = @"推荐厨友";
    [self addSubview:label];
}

- (void)createScrollView {
 
    CGFloat imageViewWidth = self.frame.size.height * 0.3;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREENWIDTH, self.frame.size.height - 40)];
    _scrollView.contentOffset =  CGPointMake(0, 0);
    _scrollView.contentSize = CGSizeMake((imageViewWidth + 20) * _newuserArray.count, self.frame.size.height - 40);
    _scrollView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    for (int i = 0;i < self.newuserArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i *
        (imageViewWidth + 20) + 10, 30, imageViewWidth, imageViewWidth)];
        
        imageView.layer.cornerRadius = imageViewWidth / 2;
        imageView.layer.masksToBounds = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[self.newuserArray[i] profileImageUrl]]];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * (imageViewWidth + 20), imageViewWidth + 45, imageViewWidth + 20, 20)];
        label.text = [self.newuserArray[i] nickname];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:label];
        
        imageView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 /255.0 green:arc4random() % 256 /255.0 blue:arc4random() % 256 /255.0 alpha:1.0];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        
        [_scrollView addSubview:imageView];
       
    }
    [self addSubview:_scrollView];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    CGFloat offset = CGRectGetMaxX(imageView.frame);
    NSInteger i = offset / (self.frame.size.height * 0.3 + 20);

    [[NSNotificationCenter defaultCenter] postNotificationName:@"厨友推荐" object:_newuserArray[i]];
}



@end
