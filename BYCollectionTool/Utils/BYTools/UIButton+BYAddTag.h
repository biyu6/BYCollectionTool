//
//  UIButton+BYAddTag.h
//  ZhiHuiLiJiang
//
//  Created by 胡忠诚 on 2018/11/19.
//  Copyright © 2018 WisdomLijiang. All rights reserved.
//按钮点击事件的分类

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (BYAddTag)
@property(nonatomic ,copy)void(^block)(UIButton*);

- (void)addTapBlock:(void(^)(UIButton*btn))block;


@end

NS_ASSUME_NONNULL_END
