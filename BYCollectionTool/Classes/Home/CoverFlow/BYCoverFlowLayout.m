//
//  BYCoverFlowLayout.m
//  OnlineEdu
//
//  Created by biyu6 on 2019/3/6.
//  Copyright © 2019 cameroon. All rights reserved.
//CoverFlow自定义layout

#import "BYCoverFlowLayout.h"

@implementation BYCoverFlowLayout
- (void)prepareLayout {
    [super prepareLayout];
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {// 当bounds发生变化的时候是否应该重新进行布局
    return YES;
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //计算中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    //获取所有的attributes对象
    NSArray *arrayAttrs = [super layoutAttributesForElementsInRect:rect];
    //循环遍历这些attributes对象, 对每个对象进行缩放
    for (UICollectionViewLayoutAttributes *attr in arrayAttrs) {
        // 获取每个cell的中心点的x值
        CGFloat cell_centerX = attr.center.x;
        // 计算这两个中心点的x值的偏移（距离）
        CGFloat distance = ABS(cell_centerX - centerX);
        CGFloat factor = 0.003;// 缩放系数
        CGFloat scale = 1 / (1 + distance * factor);
        attr.size = CGSizeMake(self.itemSize.width * 1.5, self.itemSize.height * 1.5);
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arrayAttrs;
}
/**参数1 自然滚动的情况下进行的偏移
 * 参数2 滚动的速度（poit/second ）点/秒
 * 返回值: 手动指定滚动的偏移（手动指定滚动到什么位置）
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    //计算中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
    //计算可视区域
    CGFloat visibleX = proposedContentOffset.x;
    CGFloat visibleY = proposedContentOffset.y;
    CGFloat visibleW = self.collectionView.bounds.size.width;
    CGFloat visibleH = self.collectionView.bounds.size.height;
    CGRect visibleRect = CGRectMake(visibleX, visibleY, visibleW, visibleH);
    //获取可视区域之内的所有的cell的attribute对象
    NSArray *arrayAttrs = [super layoutAttributesForElementsInRect:visibleRect];
    //用每个cell的中心点和centerX进行比较, 最终比较出一个距离最短的值
    int min_idx = 0;
    UICollectionViewLayoutAttributes *min_attr = arrayAttrs[min_idx];
    for (int i = 1; i < arrayAttrs.count; i++) {
        UICollectionViewLayoutAttributes *attr = arrayAttrs[i];
        if (ABS(attr.center.x - centerX) < ABS(min_attr.center.x - centerX)) {
            min_idx = i;
            min_attr = attr;
        }
    }
    //计算出距离中心点最小的那个cell 和中心点的偏移
    CGFloat offsetX = min_attr.center.x - centerX;
    //返回一个新的x偏移点,y的偏移点不变
    return CGPointMake(proposedContentOffset.x + offsetX, proposedContentOffset.y);
}


@end
