//
//  RecipeSearchBar.m
//  Cook
//
//  Created by 叶旺 on 16/4/25.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "RecipeSearchBar.h"

@implementation RecipeSearchBar


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"食谱、食材搜索";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        searchIcon.image = [UIImage imageNamed:@"searchbar_second_textfield_search_icon"];
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
