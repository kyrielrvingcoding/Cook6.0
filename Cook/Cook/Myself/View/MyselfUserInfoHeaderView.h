//
//  MyselfUserInfoHeaderView.h
//  Cook
//
//  Created by lanou on 16/4/27.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyselfUserInfoModel.h"

@interface MyselfUserInfoHeaderView : UIView

@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroungImageView;
@property (strong, nonatomic) IBOutlet UILabel *signatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *careLable;
@property (strong, nonatomic) IBOutlet UILabel *jiondate;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UIButton *message;
@property (strong, nonatomic) IBOutlet UIButton *caring;
@property (strong, nonatomic) IBOutlet UIButton *care;
@property (strong, nonatomic) IBOutlet UIButton *fans;
@property (strong, nonatomic) IBOutlet UILabel *nicknameLabel;

- (void)setDataWithModel:(MyselfUserInfoModel *)model;

@property (nonatomic, copy) void (^judgeLoginStatus)(UIButton *button);

@end
