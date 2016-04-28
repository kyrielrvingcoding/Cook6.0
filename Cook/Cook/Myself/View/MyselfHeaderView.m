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
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

#pragma mark ---- 数据请求 ----
- (void)requestData {
    _headerImageview.layer.cornerRadius = SCREENWIDTH / 10;
    _headerImageview.layer.masksToBounds = YES;
    NSString *sessionID = [UserInofManager getSessionID];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameter = @{@"m":@"mobile", @"c":@"index", @"a":@"getUserData", @"sessionId":sessionID};
    [manager GET:@"http://www.xdmeishi.com/index.php" parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dic[@"data"];
        
        UserLoginModel *userModel = [[UserLoginModel alloc] init];
        [userModel setValuesForKeysWithDictionary:dataDic];
        [self createBackgroundViewAndHeaderView];
        [self setDataToViewsWithModel:userModel];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
}

#pragma mark ----- 我的背景和头像 --------
- (void)setDataToViewsWithModel:(UserLoginModel *)model {
    if (model.nickname) {
        [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:model.profileImageUrl]];
        [_headerImageview sd_setImageWithURL:[NSURL URLWithString:model.profileImageUrl]];
        _nicknameLabel.text = model.nickname;
        _jionTimeLabel.text = [self figuringoutTimesFromNowWith:model.joinDate];
        _addressLabel.text = model.residence;
        NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 关注", model.concernCount]];
        [string1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
        [string1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, 1)];
        _careLabel.attributedText = string1;
        NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 粉丝", model.FansCount]];
        [string2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
        [string2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, 1)];
        _fansLabel.attributedText = string2;
    } else {
        _backgroundImageView.image = [UIImage imageNamed:@"test"];
        _headerImageview.image = [UIImage imageNamed:@"login_icon"];
        _nicknameLabel.text = @"昵称";
        _jionTimeLabel.text = @"";
        _addressLabel.text = @"地址";
        _careLabel.text = @"关 注";
        _fansLabel.text = @"粉 丝";
    }
}

- (void)createBackgroundViewAndHeaderView {
    
    //添加模糊层
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = CGRectMake(0, -200, self.frame.size.width, self.frame.size.height + 220);
    effectView.alpha = 0.9;
    effectView.userInteractionEnabled = YES;
    [_backgroundImageView addSubview:effectView];
    
    //添加手势点击事件
    UITapGestureRecognizer *carelabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLabel:)];
    [_careLabel addGestureRecognizer:carelabelTap];
    UITapGestureRecognizer *fanslabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLabel:)];
    [_fansLabel addGestureRecognizer:fanslabelTap];
    
    //轻点头像，跳转到设置到个人设置界面
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personalSet:)];
    [_headerImageview addGestureRecognizer:tap];

}
#pragma mark ----- action -------

//跳转到“我的关注”或者@“我的粉丝”(没有登录时，跳转到登录)
- (void)clickLabel:(UITapGestureRecognizer *)tap {
    UILabel *label = (UILabel *)tap.view;
    _judgeLoginStatus(label);
    NSLog(@"1111");
}

//轻点头像，跳转到设置到个人设置界面(没有登录时，跳转到登录)
- (void)personalSet:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    _judgeLoginOrQuit(imageView);
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
