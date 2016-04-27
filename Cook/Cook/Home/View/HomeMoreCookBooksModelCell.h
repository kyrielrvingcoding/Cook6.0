//
//  HomeMoreCookBooksModelCell.h
//  Cook
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface HomeMoreCookBooksModelCell : BaseTableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *leftImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ingredientsLabel;
@property (strong, nonatomic) IBOutlet UILabel *hitsCount;
@property (strong, nonatomic) IBOutlet UILabel *collectionCount;
@property (strong, nonatomic) IBOutlet UILabel *likeCount;
@property (strong, nonatomic) IBOutlet UILabel *commentCount;


@end
