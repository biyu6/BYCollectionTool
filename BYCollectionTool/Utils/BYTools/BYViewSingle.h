//
//  BYViewSingle.h
//  ZhiHuiLiJiang
//
//  Created by 胡忠诚 on 2018/11/19.
//  Copyright © 2018 WisdomLijiang. All rights reserved.
//搭建界面的单例

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define BYVS [BYViewSingle shareBYViewSingle]
@interface BYViewSingle : NSObject
BYSingtonH(BYViewSingle)

//其他工具
- (UIView *)topPromptStr:(NSString *)promptStr frameY:(CGFloat )frameY;//顶部无网络提示的view

//UILable
- (UILabel *)createLabText:(NSString *)text font:(UIFont *)labFont labColor:(UIColor*)color addSubView:(id)subView;//文字、字体、颜色

//UIImageView
- (UIImageView *)createImgView:(NSString *)imageName addSubView:(id)subView;//图片
- (UIImageView *)createCornerImgView:(float)corners imgName:(NSString *)imageName enabled:(BOOL)isClick addSubView:(id)subView;//圆角图片

//UIButton
- (UIButton *)createBtnNorIcon:(NSString *)norImgStr selIcon:(NSString *)selImgStr addSubView:(id)subView;//默认和选中图标
- (UIButton *)createBtnBGColor:(UIColor *)color title:(NSString *)titleStr titleColor:(UIColor *)titleColor addSubView:(id)subView;//背景+文字
- (UIButton *)createBtnImg:(NSString *)imgStr titStr:(NSString *)titleStr titColor:(UIColor *)titleColor titFont:(UIFont *)titFont addSubView:(id)subView;//图标+文字
- (UIButton *)createBtnStr:(NSString *)titleStr btnImg:(NSString *)imgStr titColor:(UIColor *)titleColor titFont:(UIFont *)titlFont addSubView:(id)subView;//图标+文字(传font)

//UIView
- (UIView *)createViewBGColor:(UIColor*)color addSubView:(id)subView;//背景色
- (UIView *)createViewCorner:(float )cornerNum BGColor:(UIColor*)color addSubView:(id)subView;//圆角+背景色
//====================================创建UITextField====================================
- (UITextField *)CreateNorTFWithKBType:(UIKeyboardType)kbType placeholder:(NSString *)placeholderStr tiFont:(UIFont *)tiFont textColor:(UIColor *)textColor addSubView:(id)subView;

//UIScrollView
- (UIScrollView *)createScrollViewContentSize:(CGSize)contentSize addSubView:(id)subView;


@end

NS_ASSUME_NONNULL_END
