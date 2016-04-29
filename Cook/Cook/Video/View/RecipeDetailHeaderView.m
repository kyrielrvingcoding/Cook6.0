//
//  RecipeDetailHeaderView.m
//  Cooker
//
//  Created by 诸超杰 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "RecipeDetailHeaderView.h"
#import "RecipeMaterialCell.h"
#import "RecipeDetailModel.h"
#import "NSURL+AppendingURL.h"

static NSString *RecipeMaterialCellReuseIdentifier = @"RecipeMaterialCellReuseIdentifier";
@interface RecipeDetailHeaderView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) RecipeDetailModel *recipeDetailModel;
@property (nonatomic, strong) NewRecipeDetailModel *RecipeNewDetailModel;
@property (nonatomic, strong) NSString *ID;
@end

@implementation RecipeDetailHeaderView


- (void)setModel:(BaseModel *)model {
    
    if (model == nil) {
        return;
    }
    self.materialTabelView.dataSource = self;
    self.materialTabelView.delegate = self;
    self.materialTabelView.bounces = NO;
    self.materialTabelView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.materialTabelView registerNib:[UINib nibWithNibName:@"RecipeMaterialCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RecipeMaterialCellReuseIdentifier];

    RecipeDetailModel *detailModel = (RecipeDetailModel *)model;
    self.titleLabel.text = detailModel.name;
    
    self.iconName.text = detailModel.authorname;
    self.dateLabel.text = detailModel.gettime;
    self.describeLabel.text = detailModel.Description;

    self.iconImage.layer.masksToBounds = YES;
    self.iconImage.layer.cornerRadius = 20;
#pragma mark   ========扣死二第切图
    
    NSDictionary *parameter = @{@"version":@"12.2.1.0",@"machine":@"O382baa3c128b3de78ff6bbcd395b2a27194b01ad",@"device":@"iPhone8%2C1",@"frienduid":detailModel.authorid};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:SELECTUSER_URL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *pic = responseObject[@"pic"];
        if (pic) {
            [self.iconImage sd_setImageWithURL:[NSURL stringAppendingToURLWithString:pic] placeholderImage:[UIImage imageNamed:@"头像"]];
        } else {
            self.iconImage.image = [UIImage imageNamed:@"头像"];
        }
        [self.iconImage sd_setImageWithURL:[NSURL stringAppendingToURLWithString:pic] placeholderImage:[UIImage imageNamed:@"头像"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"用户头像请求失败");
    }];
    
}

- (CGFloat)returnHeightByModel:(BaseModel *)model {
    if (model == nil) {
        return 0;
    }
    self.recipeDetailModel = (RecipeDetailModel *)model;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil];
    NSString *description =  nil;
    if (model.Description) {
        description = model.Description;
    } else {
        description = @"   ";
    }
   
    CGRect rect = [description boundingRectWithSize:CGSizeMake(SCREENWIDTH - 30, 3000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat strHeight = rect.size.height;
    CGFloat stepHeight = 0;
    if (self.recipeDetailModel.materialListModelArray.count) {
        stepHeight = (self.recipeDetailModel.materialListModelArray.count ) * 30;
    }
    CGFloat height = strHeight + stepHeight + 550 - 232 - 29;
    return height;
}

- (void)setNewModel:(NewRecipeDetailModel *)model {
    if (model == nil) {
        return;
    }
    _ID = model.userModel.ID;
    self.materialTabelView.dataSource = self;
    self.materialTabelView.delegate = self;
    self.materialTabelView.bounces = NO;
    self.materialTabelView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.materialTabelView registerNib:[UINib nibWithNibName:@"RecipeMaterialCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RecipeMaterialCellReuseIdentifier];
    
    self.titleLabel.text = model.name;
    
    self.iconName.text = model.userModel.nickname;
    self.dateLabel.text = model.uploadDate;
    self.describeLabel.text = model.Description;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.userModel.profileImageUrl]];
    self.iconImage.layer.masksToBounds = YES;
    self.iconImage.layer.cornerRadius = 20;
    self.iconImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userInfo:)];
    [self.iconImage addGestureRecognizer:tap];

}

- (void)userInfo: (UITapGestureRecognizer *)tap {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"跳转到用户详情界面" object:nil userInfo:@{@"key":_ID}];
}

- (CGFloat)newReturnHeightByModel:(NewRecipeDetailModel *)model {
    if (model == nil) {
        return 0;
    }
    _RecipeNewDetailModel = model;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil];
    NSString *description =  nil;
    if (model.Description) {
        description = model.Description;
    } else {
        description = @"   ";
    }
    
    CGRect rect = [description boundingRectWithSize:CGSizeMake(SCREENWIDTH - 30, 3000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat strHeight = rect.size.height;
    CGFloat stepHeight = 0;
    if (model.ingredientsArray.count) {
        stepHeight = model.ingredientsArray.count  * 30;
    }
    CGFloat height = strHeight + stepHeight + 550 - 232 - 29;
    return height;
}


#pragma mark tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.recipeDetailModel) {
        return self.recipeDetailModel.materialListModelArray.count;
    } else if (self.RecipeNewDetailModel){
        return self.RecipeNewDetailModel.ingredientsArray.count;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeMaterialCell *cell = [tableView dequeueReusableCellWithIdentifier:RecipeMaterialCellReuseIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ((int)(indexPath.row % 2) == 1) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:208 / 255.0 green:208 / 255.0 blue:208 / 255.0 alpha:1];
    }
    if (self.recipeDetailModel) {
        materialListModel *model = self.recipeDetailModel.materialListModelArray[indexPath.row];
        if (model.name) {
            cell.name.text = model.name;
        }
        if (model.dosage) {
            cell.number.text = model.dosage;
        } else {
            cell.number.text = @"";
        }
    }
    if (self.RecipeNewDetailModel) {
        IngredientsModel *model = self.RecipeNewDetailModel.ingredientsArray[indexPath.row];
        
        if (model.name) {
            if (model.isMain) {
                cell.name.text = [NSString stringWithFormat:@"主材:%@",model.name];
            } else {
                cell.name.text = model.name;
            }
            
        }
        if (model.unit) {
            cell.number.text = model.unit;
        } else {
            cell.number.text = @"";
        }
    }
       return cell;
}
@end
