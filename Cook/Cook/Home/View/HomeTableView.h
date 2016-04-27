//
//  HomeTableView.h
//  Cook
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHeaderView.h"
#import "HomeFooterView.h"
#import "HomeReferrerModel.h"
#import "HomeMoreCookBooksModel.h"

@interface HomeTableView : UITableView

@property (nonatomic, strong) NSMutableArray *moreCookbooksArray;//推荐数据源

@end
