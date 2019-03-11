//
//  BYIconFlowLayout.m
//  BYCollectionTool
//
//  Created by biyu6 on 2019/3/11.
//  Copyright © 2019 biyu6. All rights reserved.
//不同高度图片布局的layout

#import "BYIconFlowLayout.h"

#define columnNum 2 //列数
#define gap @"5" //item直接的间隔，默认5
@interface BYIconFlowLayout()
/**总数*/
@property(nonatomic,assign)NSInteger totalNum;
/**存下一个item的x、y的值*/
@property(nonatomic,strong)NSMutableArray *nextXY;
/**布局属性*/
@property(nonatomic,strong)NSMutableArray *layoutAttributes;
/**宽度*/
@property(nonatomic,assign)CGFloat width;

@end
@implementation BYIconFlowLayout
- (void)prepareLayout {
    [super prepareLayout];
    
    
    _nextXY = [NSMutableArray array];//存下一个item的x、y的值
    for (int i=0; i<columnNum; i++) {//遍历列数
        [_nextXY appendObject:gap];//第一个item的xy是
    }
    //总数
    _totalNum = _dataArr.count;
    _layoutAttributes = [NSMutableArray array];//布局属性
    
    for (int i=0; i<_totalNum; i++) {
        UICollectionViewLayoutAttributes *layoutA = [self layoutAttributesForItem:[NSIndexPath indexPathForRow:i inSection:0]];
        [_layoutAttributes appendObject:layoutA];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItem:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes  = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //获取item的宽度：按列数扣除item之间的间距gap 平分屏幕（最左的item距离左为gap/2、最右的item距离右为gap/2，item之间间隔gap）
    CGFloat gapF = [gap floatValue];
    CGFloat columnNumF = (CGFloat)columnNum/1.0;
    _width = (self.collectionView.bounds.size.width - gapF*columnNumF)/columnNumF;
    
    //拿到数据源中的图片img
    UIImage *img = _dataArr[indexPath.row];
    //确定每个item的宽高：高度按宽度压缩；（高度 = 图片的高度 * 规定的图片宽度 / 图片的宽度 ）
    attributes.size =CGSizeMake(_width, img.size.height*_width/img.size.width);
    
    NSInteger rank = [self getRank:_nextXY];
    CGFloat h = [self getMinH:_nextXY];
    //计算每个item的中心点
    attributes.center = CGPointMake((rank+0.5)*(gapF+_width), h+(attributes.size.height+gapF)/2.0);
    NSString *valueStr = [NSString stringWithFormat:@"%lf",h + attributes.size.height+gapF];
    _nextXY[rank] = valueStr; //下一个要显示的xy的值
    
    return attributes;
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _layoutAttributes;
}
- (CGSize)collectionViewContentSize{
    return CGSizeMake(self.collectionView.bounds.size.width,[self getMaxH:_nextXY]);
}
- (NSInteger)getRank:(NSArray *)minXY{//确定下一张图片是否换行显示(获取下一张图片x和y之间的最小值)
    NSInteger num = 0;//该item是第几列（从0开始）
    NSString *str = minXY[0];
    NSInteger min = [str integerValue];//该item的x和y中的最小值(确定是否换行显示)
    for (int i=1; i<minXY.count; i++) {
        NSString *str2 = minXY[i];
        if (min > [str2 integerValue]){
            num = i;
        }
    }
    return num;
}
- (CGFloat)getMinH:(NSArray *)minXY{//确定下一张图片是否换行显示(获取下一张图片x和y之间的最小值)
    NSString *str = minXY[0];
    NSInteger min = [str integerValue];//该item的x和y中的最小值(确定是否换行显示)
    for (int i=1; i<minXY.count; i++) {
        NSString *str2 = minXY[i];
        if (min > [str2 integerValue]) {
            min = [str2 integerValue];
        }
    }
    return (CGFloat)min;
}
- (CGFloat)getMaxH:(NSArray *)minXY{//获取瀑布流View底部的y值
    NSString *str = minXY[0];
    NSInteger max = [str integerValue];//该item的x和y中的最小值(确定是否换行显示)
    for (int i=1; i<minXY.count; i++) {
        NSString *str2 = minXY[i];
        if (max < [str2 integerValue]) {
            max = [str2 integerValue];
        }
    }
    return (CGFloat)max;
}


@end
