//
//  MyFlowLayoout.m
//  uicollectionView的基本使用
//
//  Created by Pottsmo on 16/4/21.
//  Copyright © 2016年 Pottsmo. All rights reserved.
//

#import "MyFlowLayoout.h"
#define ScreenW  [UIScreen mainScreen].bounds.size.width

@implementation MyFlowLayoout
/*
 自定义UICollectionView布局:了解5个方法
 `
 - (void)prepareLayout;
 
 - (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect;
 
 - (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds; // return YES to cause the collection view to requery the layout for geometry information
 
 - (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity; // return a point at which to rest after scrolling - for layouts that want snap-to-point scrolling behavior
 
 - (CGSize)collectionViewContentSize;
 
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
// 返回数组就是cell的布局
// 指定一段区域,就能返回这段区域内的所有cell
// 可以一次性返回所有cell的布局
// 设置cell布局
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 获取当前显示cell的区域

    // 获取当前显示cell的布局
    NSArray *attri = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    for (UICollectionViewLayoutAttributes*att in attri) {
        CGFloat deatl = fabs(att.center.x - (self.collectionView.contentOffset.x + ScreenW*0.5));
        CGFloat scale =1 - deatl /(ScreenW *0.5) *0.25;
        att.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    
    
    
    
    
    return attri;
}
/*
 定位:判断下,哪个cell离中心点距离越近,越近显示到中间
 */

// 作用:决定UICollectionView最终偏移量
// 什么时候调用:只要用户停止滑动的时候就会调用
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 获取最终显示区域
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, ScreenW, MAXFLOAT);
    // 获取最终显示cell布局
    NSArray *AttriArray = [self layoutAttributesForElementsInRect:targetRect];
    CGFloat minDetal = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attri in AttriArray) {
        // 获取每个cell距离中心点距离
        CGFloat detail = attri.center.x - (proposedContentOffset.x +ScreenW*0.5);
        
        
//        在进行比较
        if (fabs(detail)  < fabs(minDetal) ) {
            minDetal = detail;
        }
        
    }
    proposedContentOffset.x += minDetal;
    
    if (proposedContentOffset.x < 0) {
        proposedContentOffset.x = 0;
    }
    
    return proposedContentOffset;
}







@end
