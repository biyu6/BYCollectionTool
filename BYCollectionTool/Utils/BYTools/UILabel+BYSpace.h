//
//  UILabel+BYSpace.h
//  WallMeet
//
//  Created by 胡忠诚 on 2018/12/6.
//  Copyright © 2018 huaerjie. All rights reserved.
//UILabel的行间距

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (BYSpace)
//改变行间距
- (void)changeLineSpace:(float)space;

//改变行间距
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;
//改变字间距
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;
//改变行间距和字间距
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;


@end

NS_ASSUME_NONNULL_END
