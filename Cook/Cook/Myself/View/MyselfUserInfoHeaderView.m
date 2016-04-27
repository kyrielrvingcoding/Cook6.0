//
//  MyselfUserInfoHeaderView.m
//  Cook
//
//  Created by lanou on 16/4/27.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "MyselfUserInfoHeaderView.h"


@implementation MyselfUserInfoHeaderView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT * 0.45);
    }
    return self;
}

- (void)setDataWithModel:(MyselfUserInfoModel *)model {
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.profileImageUrl]];
    [_backgroungImageView sd_setImageWithURL:[NSURL URLWithString:model.profileImageUrl]];
    _signatureLabel.text = model.signature;
    _nicknameLabel.text = model.nickname;
    _jiondate.text = model.joinDate;
    _careLable.text = [NSString stringWithFormat:@"%@浏览",model.visitCount];
    _addressLabel.text = model.residence;
    //添加模糊层
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height + 20);
    effectView.alpha = 0.7;
    [_backgroungImageView addSubview:effectView];
    
    [_care setTitle:[NSString stringWithFormat:@"%@关注",model.concernCount] forState:UIControlStateNormal];
    [_fans setTitle:[NSString stringWithFormat:@"%@粉丝",model.FansCount] forState:UIControlStateNormal];
    //button添加事件
    [_care addTarget:self action:@selector(care:) forControlEvents:UIControlEventTouchUpInside];
    //button添加事件
    [_fans addTarget:self action:@selector(care:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)care:(UIButton *)button {
    _judgeLoginStatus(button);
}


- (void)changeIndicator:(NSInteger)index {
    
    for (UIView *view in self.subviews) {
        if (view.tag < 3000 && view.tag >= 2000) {
            view.backgroundColor = [UIColor lightGrayColor];
        }
    }
    UIView *view = [self viewWithTag:2000 + index];
    view.backgroundColor = [UIColor yellowColor];
}




@end
