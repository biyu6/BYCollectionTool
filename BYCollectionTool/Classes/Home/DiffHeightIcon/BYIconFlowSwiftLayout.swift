//
//  BYIconFlowSwiftLayout.swift
//  BYCollectionTool
//
//  Created by biyu6 on 2019/3/11.
//  Copyright © 2019 biyu6. All rights reserved.
//不同高度图片布局的layout

import UIKit

class BYIconFlowSwiftLayout: UICollectionViewLayout {
    var setSize:()->(Array<UIImage>) = { return []} //cell的数据源数组
    var columnNum: Int = 2 //列数，默认2列
    var gap:CGFloat = 5//item直接的间隔，默认5
    var nextXY: Array<CGFloat>! //存下一个item的x、y的值
    private var totalNum: Int! //总数
    private var layoutAttributes: Array<UICollectionViewLayoutAttributes>!
    
    override func prepare() {//重写准备的方法
        super.prepare()
        nextXY = []
        for _ in 0..<columnNum {//遍历列数
            nextXY.append(gap) //第一个item的xy是
        }
        totalNum = collectionView?.numberOfItems(inSection: 0)
        layoutAttributes = []
        var indexpath: NSIndexPath!
        for index in 0..<totalNum {
            indexpath = NSIndexPath(row: index, section: 0)
            let attributes = layoutAttributesForItem(at: indexpath as IndexPath)
            layoutAttributes.append(attributes!)
        }
    }
    private var width:CGFloat!
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        //获取item的宽度：按列数扣除item之间的间距gap 平分屏幕（最左的item距离左为gap/2、最右的item距离右为gap/2，item之间间隔gap）
        width = (collectionView!.bounds.size.width-gap*(CGFloat(columnNum)))/CGFloat(columnNum)
        //拿到数据源
        let sizes = setSize()
        //确定每个item的宽高：高度按宽度压缩；（高度 = 图片的高度 * 规定的图片宽度 / 图片的宽度 ）
        attributes.size = CGSize(width: width, height: sizes[indexPath.row].size.height*width/sizes[indexPath.row].size.width)
        
        var rank:CGFloat = 0
        var h:CGFloat = 0
        (rank,h) = minH(minXY: nextXY) //获取第rank列、下一个图的y的值
        //计算每个item的中心点
        attributes.center = CGPoint(x:(rank+0.5)*(gap+width), y:h+(attributes.size.height+gap)/2)
        nextXY[Int(rank)] = h + attributes.size.height+gap //下一个要显示的xy的值
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
    
    //重写collectionViewContentSize属性
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: (collectionView?.bounds.width)!, height: maxH(minXY: nextXY))
        }
        set {
            self.collectionViewContentSize = newValue
        }
    }
    
    private func minH(minXY:Array<CGFloat>)->(CGFloat,CGFloat){//确定下一张图片是否换行显示(获取下一张图片x和y之间的最小值)
        var num = 0//该item是第几列（从0开始）
        var min = minXY[0]//该item的x和y中的最小值(确定是否换行显示)
        for i in 1..<minXY.count{
            if min>minXY[i] {
                min = minXY[i]
                num = i
            }
        }
        return (CGFloat(num),min)//返回列、xy的最小值
    }
    func maxH(minXY:Array<CGFloat>)->CGFloat{//获取瀑布流View底部的y值
        var max = minXY[0]
        for i in 1..<minXY.count{
            if max<minXY[i] {
                max = minXY[i]
            }
        }
        return max
    }
}


