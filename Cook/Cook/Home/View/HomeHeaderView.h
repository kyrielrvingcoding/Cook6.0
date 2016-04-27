//
//  HomeHeaderView.h
//  Cook
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeAdvertsModel.h"
#import "CycleScrollView.h"
#import "HomeHotCategoriesModel.h"


@interface HomeHeaderView : UIView

@property (nonatomic, strong) CycleScrollView *cycleScrollView;//轮播图
@property (nonatomic, strong) NSMutableArray *advertsArray;//轮播图数据源
@property (nonatomic, strong) NSMutableArray *hotCategoriesArray;//类别的数组


@end
