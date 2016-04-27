//
//  NewRecipeDetailFootView.m
//  Cook
//
//  Created by 诸超杰 on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "NewRecipeDetailFootView.h"
#import "NewRecipeDetailStepCell.h"

static NSString *NewRecipeDetailStepCellIdentifier = @"NewRecipeDetailStepCell";
@interface NewRecipeDetailFootView ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *DescriptionLabel;
@property (nonatomic, strong) NSMutableArray *DataArray;
@end
@implementation NewRecipeDetailFootView
- (void)setNewRecipeDetaileModel:(NewRecipeDetailModel *)model {
    
}
- (CGFloat)getHeightByNewRecipeDetaileModel:(NewRecipeDetailModel *)model {
    if (!model) {
        return 0;
    }
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.bounces = NO;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"NewRecipeDetailStepCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NewRecipeDetailStepCellIdentifier];
    
    NSString *descriptionStr = model.warmTip;
    CGFloat height = 0;
    if (descriptionStr) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
        CGRect rect = [descriptionStr boundingRectWithSize:CGSizeMake(SCREENWIDTH - 35, 1000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
         height = rect.size.height;
    }
    if (model.commentsArray.count) {
        _DataArray = [[NSMutableArray alloc] initWithCapacity:0];
        _DataArray = model.commentsArray;
    }
    CGFloat cellHeights = 112 * model.commentsArray.count;
    
        return 100 + cellHeights + height;
}

#pragma mark ------tableView 的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _DataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NewRecipeDetailStepCell *cell = [tableView dequeueReusableCellWithIdentifier:NewRecipeDetailStepCellIdentifier forIndexPath:indexPath];
    CommentsModel *model = _DataArray[indexPath.row];
    cell.DescriptionLabel.text = model.content;
    cell.name.text = model.UserModel.nickname;
    [cell.headerImageVIew sd_setImageWithURL:[NSURL URLWithString:model.UserModel.profileImageUrl]];
    cell.dateLabel.text = model.date;
    return cell;
}

@end
