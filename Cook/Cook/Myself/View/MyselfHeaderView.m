//
//  MyselfHeaderView.m
//  Cook
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "MyselfHeaderView.h"
#import "UserInofManager.h"

@implementation MyselfHeaderView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT * 0.4);
    }
    return self;
}

#pragma mark ---- 数据请求 ----
- (void)requestData {
    NSString *sessionID = [UserInofManager getSessionID];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameter = @{@"m":@"mobile", @"c":@"index", @"a":@"getUserData", @"sessionId":sessionID};
    [manager GET:@"http://www.xdmeishi.com/index.php" parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@"--------%@", dic);
        NSDictionary *dataDic = dic[@"data"];
        
        UserLoginModel *userModel = [[UserLoginModel alloc] init];
        [userModel setValuesForKeysWithDictionary:dataDic];
        [self createBackgroundViewAndHeaderView:userModel];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
}

#pragma mark ----- 我的背景和头像 --------
- (void)createBackgroundViewAndHeaderView:(UserLoginModel *)model {
    if (model.nickname) {
        [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:model.profileImageUrl]];
        [_headerImageview sd_setImageWithURL:[NSURL URLWithString:model.profileImageUrl]];
        _nicknameLabel.text = model.nickname;
        _jionTimeLabel.text = [self figuringoutTimesFromNowWith:model.joinDate];
        _addressLabel.text = model.residence;
    }
    
//    _careLabel.text = model
    //添加模糊层
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height + 20);
    effectView.alpha = 0.9;
    [_backgroundImageView addSubview:effectView];
    
    //button添加事件
    [_careButton addTarget:self action:@selector(care:) forControlEvents:UIControlEventTouchUpInside];
    //button添加事件
    [_fansButton addTarget:self action:@selector(care:) forControlEvents:UIControlEventTouchUpInside];
    
    //轻点头像，跳转到设置到个人设置界面
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personalSet:)];
    [_headerImageview addGestureRecognizer:tap];

}
#pragma mark ----- action -------

//跳转到“我的关注”或者@“我的粉丝”(没有登录时，跳转到登录)
- (void)care:(UIButton *)button {
    _judgeLoginStatus(button);
}

//轻点头像，跳转到设置到个人设置界面(没有登录时，跳转到登录)
- (void)personalSet:(UITapGestureRecognizer *)tap {
    
}

- (NSString *)figuringoutTimesFromNowWith:(NSString *)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:time];
    NSDate *nowDate = [NSDate date];
    NSTimeInterval seconds = [nowDate timeIntervalSinceDate:date];
    NSInteger hours = (NSInteger)seconds / (60 * 60);
    NSInteger days = (NSInteger)hours / 24;
    NSString *timeStr = nil;
    if (hours < 24) {
        timeStr = [NSString stringWithFormat:@"已加入%ld小时", hours];
    } else {
        timeStr = [NSString stringWithFormat:@"已加入%ld天", days];
    }
    return timeStr;
}

@end
