//
//  UIButton+BYAddTag.m
//  ZhiHuiLiJiang
//
//  Created by 胡忠诚 on 2018/11/19.
//  Copyright © 2018 WisdomLijiang. All rights reserved.
//按钮点击事件的分类

#import "UIButton+BYAddTag.h"
#import <objc/runtime.h>

@implementation UIButton (BYAddTag)
- (void)addTapBlock:(void(^)(UIButton*))block{
    self.block= block;
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
}
- (void)setBlock:(void(^)(UIButton*))block{
    objc_setAssociatedObject(self,@selector(block), block,OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
}
- (void(^)(UIButton*))block{
    return objc_getAssociatedObject(self,@selector(block));
}
- (void)click:(UIButton*)btn{
    if(self.block) {
        self.block(btn);
    }
}


@end
