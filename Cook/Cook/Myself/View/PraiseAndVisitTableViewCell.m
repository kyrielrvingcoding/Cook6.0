//
//  PraiseAndVisitTableViewCell.m
//  Cook
//
//  Created by 叶旺 on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "PraiseAndVisitTableViewCell.h"
#import "HomeNewUserModel.h"

@implementation PraiseAndVisitTableViewCell

- (IBAction)cancelPraise:(id)sender {
}

- (void)setDataWithModel:(HomeNewUserModel *)model {
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.profileImageUrl]];
    _nickNameLabel.text = model.nickname;
    _signatureLabel.text = model.signature;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
