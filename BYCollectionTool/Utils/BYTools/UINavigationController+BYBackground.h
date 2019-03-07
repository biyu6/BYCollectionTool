//
//  UINavigationController+BYBackground.h
//  WallMeet
//
//  Created by 胡忠诚 on 2018/12/2.
//  Copyright © 2018 huaerjie. All rights reserved.
//导航栏的颜色及透明度


#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (BYBackground)<UINavigationBarDelegate, UINavigationControllerDelegate>
@property (copy, nonatomic) NSString *cloudox;
- (void)setNeedsNavigationBackground:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
