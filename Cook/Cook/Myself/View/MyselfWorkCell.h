//
//  MyselfWorkCell.h
//  Cook
//
//  Created by lanou on 16/4/28.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MyselfWorkCell : BaseTableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *leftImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *likeLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;

@end
