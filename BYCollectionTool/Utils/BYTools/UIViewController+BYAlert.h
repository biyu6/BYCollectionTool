//
//  UIViewController+BYAlert.h
//  ZhiHuiLiJiang
//
//  Created by 胡忠诚 on 2018/11/19.
//  Copyright © 2018 WisdomLijiang. All rights reserved.
//弹框事件

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^click)(NSInteger index);
typedef void(^configuration)(UITextField *field, NSInteger index);
typedef void(^clickHaveField)(NSArray<UITextField *> *fields, NSInteger index);

@interface UIViewController (BYAlert)
//==========================导航栏背景透明度=============================
@property (copy, nonatomic) NSString *navBarBgAlpha;


//==========================导航栏=============================
typedef void(^LeftSel)(void);
//导航栏的titleViewImage
- (void)setTitleImageView:(NSString *)iconName;
- (void)setRightImg:(NSString *)imgStr rightAction:(void(^)(void))action;//设置导航栏右侧按钮
//设置导航栏的title和返回按钮
- (void)setTitleStr:(nullable NSString *)titleStr leftAction:(LeftSel)action;
//设置导航栏右侧按钮
- (void)setRightTitleStr:(NSString *)rightStr titleColor:(UIColor *)titColor rightAction:(void(^)(void))action;
//设置导航栏返回按钮和titeView
- (void)setTitleImageNameStr:(NSString *)iconNameStr leftAction:(LeftSel)action;

//==========================Alert和Sheet=============================
//alert弹框（标题、信息、按钮title的数组、是否动画、按钮的点击事件
- (void)AlertWithTitle:(NSString *)title message:(NSString *)message andOthers:(NSArray<NSString *> *)others animated:(BOOL)animated action:(click)click;
//Alert (标题、信息、按钮数组、文本框个数、文本框和其编号、点击了那个按钮以及所有文本框的数组
- (void)AlertWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray<NSString *> *)buttons textFieldNumber:(NSInteger )number configuration:(configuration )configuration animated:(BOOL )animated action:(clickHaveField )click;

//ActionSheet弹框（标题、信息、信息下面的信息(可为nil)、点击了按钮下面的信息、按钮title的数组、按钮的点击事件
- (void)ActionSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message destructive:(nullable NSString *)destructive destructiveAction:(click )destructiveAction andOthers:(NSArray <NSString *> *)others animated:(BOOL )animated action:(click )click;


@end

NS_ASSUME_NONNULL_END
