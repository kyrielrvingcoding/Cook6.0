//
//  RecipeWaterfallFlowLayout.h
//  Cook
//
//  Created by 叶旺 on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecipeWaterfallFlowLayout;
@protocol WaterFlowLayoutDelegate <NSObject>

//关键方法，此方法的作用是返回每一个item的size大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(RecipeWaterfallFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(RecipeWaterfallFlowLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(RecipeWaterfallFlowLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(RecipeWaterfallFlowLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

@end

@interface RecipeWaterfallFlowLayout : UICollectionViewLayout

//瀑布流一共多少列
@property (nonatomic, assign) NSUInteger numberOfColumn;

@property (nonatomic, assign) id<WaterFlowLayoutDelegate>delegate;

@end
