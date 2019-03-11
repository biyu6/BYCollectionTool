//
//  BYIconFlowLayout.h
//  BYCollectionTool
//
//  Created by biyu6 on 2019/3/11.
//  Copyright © 2019 biyu6. All rights reserved.
//不同高度图片布局的layout

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BYIconFlowLayout : UICollectionViewFlowLayout
/**cell的数据源数组*/
@property(nonatomic,strong)NSArray *dataArr;


@end

NS_ASSUME_NONNULL_END
