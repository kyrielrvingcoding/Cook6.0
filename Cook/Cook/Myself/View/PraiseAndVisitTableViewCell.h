//
//  PraiseAndVisitTableViewCell.h
//  Cook
//
//  Created by 叶旺 on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface PraiseAndVisitTableViewCell : BaseTableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *signatureLabel;
@property (strong, nonatomic) IBOutlet UIButton *concernBtn;

@end
