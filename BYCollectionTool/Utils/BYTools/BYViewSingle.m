//
//  BYViewSingle.m
//  ZhiHuiLiJiang
//
//  Created by 胡忠诚 on 2018/11/19.
//  Copyright © 2018 WisdomLijiang. All rights reserved.
//搭建界面的单例

#import "BYViewSingle.h"

@implementation BYViewSingle
BYSingtonM(BYViewSingle)
//其他
- (UIView *)topPromptStr:(NSString *)promptStr frameY:(CGFloat )frameY{//顶部无网络提示的view
    UIView *topPromptView = [[UIView alloc] initWithFrame:CGRectMake(0, frameY, BYScreenWidth, 40)];
    UILabel *refreshLabel = [[UILabel alloc] initWithFrame:topPromptView.bounds];
    refreshLabel.textColor = [UIColor colorWithHexString:@"#3cc0f2"];
    refreshLabel.font = [UIFont systemFontOfSize:14];
    refreshLabel.textAlignment = NSTextAlignmentCenter;
    refreshLabel.text = promptStr;//@"网络不给力 请稍后再试";
    [topPromptView addSubview:refreshLabel];
    topPromptView.backgroundColor = [UIColor colorWithHexString:@"#d4f0fa"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [topPromptView removeFromSuperview];
    });
    return topPromptView;
}

#pragma mark- UILable
- (UILabel *)createLabText:(NSString *)text font:(UIFont *)labFont labColor:(UIColor*)color addSubView:(id)subView{//文字、字体、颜色
    UILabel *lab  = [[UILabel alloc] init];
    if (text.length > 0) {
        lab.text = text;
    }
    lab.font = labFont;
    lab.textColor= color;
    [subView addSubview:lab];
    
    return lab;
}

#pragma mark- UIImageView
- (UIImageView *)createImgView:(NSString *)imageName addSubView:(id)subView{//图片
    UIImageView *imgView = [[UIImageView alloc]init];
    if (imageName.length > 0) {
        imgView.image = [UIImage imageNamed:imageName];
    }
    [subView addSubview:imgView];
    return imgView;
}
- (UIImageView *)createCornerImgView:(float)corners imgName:(NSString *)imageName enabled:(BOOL)isClick addSubView:(id)subView{//圆角图片
    UIImageView *imgView = [[UIImageView alloc]init];
    if (imageName.length > 0) {
        imgView.image = [UIImage imageNamed:imageName];
    }
    imgView.layer.cornerRadius = corners;
    imgView.layer.masksToBounds = YES;
    imgView.userInteractionEnabled = isClick;
    [subView addSubview:imgView];
    return imgView;
}

#pragma mark- UIButton
- (UIButton *)createBtnNorIcon:(NSString *)norImgStr selIcon:(NSString *)selImgStr addSubView:(id)subView{//默认和选中图标
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:norImgStr] forState:UIControlStateNormal];
    if (selImgStr.length > 0) {
        [btn setImage:[UIImage imageNamed:selImgStr] forState:UIControlStateSelected];
    }
    [subView addSubview:btn];
    return btn;
}
- (UIButton *)createBtnBGColor:(UIColor *)color title:(NSString *)titleStr titleColor:(UIColor *)titleColor addSubView:(id)subView{//背景+文字
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = color;
    [btn setTitle:titleStr forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [subView addSubview:btn];
    return btn;
}
- (UIButton *)createBtnImg:(NSString *)imgStr titStr:(NSString *)titleStr titColor:(UIColor *)titleColor titFont:(UIFont *)titFont addSubView:(id)subView{//图标+文字
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    if (titleStr.length > 0) {
        [btn setTitle:titleStr forState:UIControlStateNormal];
    }
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = titFont;
    //    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    //    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    [subView addSubview:btn];
    return btn;
}
- (UIButton *)createBtnStr:(NSString *)titleStr btnImg:(NSString *)imgStr titColor:(UIColor *)titleColor titFont:(UIFont *)titlFont addSubView:(id)subView{//图标+文字(传font)
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    if (titleStr.length > 0) {
        [btn setTitle:titleStr forState:UIControlStateNormal];
    }
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = titlFont;
    [subView addSubview:btn];
    return btn;
}

#pragma mark- UIView
- (UIView *)createViewBGColor:(UIColor*)color addSubView:(id)subView{//背景色
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    [subView addSubview:view];
    return view;
}
- (UIView *)createViewCorner:(float )cornerNum BGColor:(UIColor*)color addSubView:(id)subView{//圆角 + 背景色
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = cornerNum;
    view.layer.masksToBounds = YES;
    view.backgroundColor = color;
    [subView addSubview:view];
    return view;
}
//====================================创建UITextField====================================
- (UITextField *)CreateNorTFWithKBType:(UIKeyboardType)kbType placeholder:(NSString *)placeholderStr tiFont:(UIFont *)tiFont textColor:(UIColor *)textColor addSubView:(id)subView{
    UITextField *tf    = [[UITextField alloc]init];
    tf.keyboardType = kbType;
    tf.textColor = textColor;
    tf.placeholder     = placeholderStr;
    tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderStr attributes:@{NSForegroundColorAttributeName: BYBlackColor5}];
    tf.font            = tiFont;
    [subView addSubview:tf];
    
    return tf;
}

//====================================UIScrollView====================================
- (UIScrollView *)createScrollViewContentSize:(CGSize)contentSize addSubView:(id)subView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.contentSize = contentSize;
    [subView addSubview:scrollView];
    return  scrollView;
}


@end
