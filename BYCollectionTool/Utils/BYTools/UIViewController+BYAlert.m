//
//  UIViewController+BYAlert.m
//  ZhiHuiLiJiang
//
//  Created by 胡忠诚 on 2018/11/19.
//  Copyright © 2018 WisdomLijiang. All rights reserved.
//弹框事件

#import "UIViewController+BYAlert.h"
#import <objc/runtime.h>
#import "UINavigationController+BYBackground.h"

static NSMutableArray *fields = nil;
@implementation UIViewController (BYAlert)
#pragma mark- 导航栏背景透明度
//定义常量 必须是C语言字符串
static char *CloudoxKey = "CloudoxKey";
- (void)setNavBarBgAlpha:(NSString *)navBarBgAlpha {
    /*id object 给哪个对象的属性赋值
     const void *key 属性对应的key
     id value  设置属性值为value
     objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
     */
    objc_setAssociatedObject(self, CloudoxKey, navBarBgAlpha, OBJC_ASSOCIATION_COPY_NONATOMIC);
    // 设置导航栏透明度（利用Category自己添加的方法）
    [self.navigationController setNeedsNavigationBackground:[navBarBgAlpha floatValue]];
}
- (NSString *)navBarBgAlpha {
    return objc_getAssociatedObject(self, CloudoxKey) ? : @"1.0";
}

#pragma mark- 导航栏
- (void)setTitleStr:(nullable NSString *)titleStr leftAction:(LeftSel)action{//设置导航栏的title和返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImage = [UIImage imageNamed:@"arrow_left"] ;
    [backBtn setImage:backImage forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
    [backBtn addTapBlock:^(UIButton * _Nonnull btn) {
        action();
    }];
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    //设置title
    if (titleStr != nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, 0, BYWidth(50), 44);
        titleLabel.textColor = BYBlackColor5;
        titleLabel.font = BYFontSize(17);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = titleStr;
        self.navigationItem.titleView = titleLabel;
    }
}
- (void)setTitleImageView:(NSString *)iconName{//导航栏的titleViewImage
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];//icon_iphone
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationItem.titleView = image;
}
- (void)setRightImg:(NSString *)imgStr rightAction:(void(^)(void))action{//设置导航栏右侧按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 18, 18);
    [rightBtn addTapBlock:^(UIButton * _Nonnull btn) {
        action();
    }];
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];

}
- (void)setRightTitleStr:(NSString *)rightStr titleColor:(UIColor *)titColor rightAction:(void(^)(void))action{//设置导航栏右侧按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:rightStr forState:UIControlStateNormal];
    [rightBtn setTitleColor:titColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = BYFontSize(15);
    rightBtn.frame = CGRectMake(0, 0, BYWidth(50), 44);
    [rightBtn addTapBlock:^(UIButton * _Nonnull btn) {
        action();
    }];
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
- (void)setTitleImageNameStr:(NSString *)iconNameStr leftAction:(LeftSel)action{//设置导航栏返回按钮和titeView
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImage = [UIImage imageNamed:@"arrow_left"];
    [backBtn setImage:backImage forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
    [backBtn addTapBlock:^(UIButton * _Nonnull btn) {
        action();
    }];
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    //titleView
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconNameStr]];//icon
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationItem.titleView = image;
}

#pragma mark- AlertView
//alert弹框（标题、信息、按钮title的数组、是否动画、按钮的点击事件
- (void)AlertWithTitle:(NSString *)title message:(NSString *)message andOthers:(NSArray<NSString *> *)others animated:(BOOL)animated action:(click)click{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [others enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0){
            [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (action){
                    click(idx);
                }
            }]];
        }else {
            [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (action){
                    click(idx);
                }
            }]];
        }
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController: alertController animated: YES completion: nil];
    });
}
//Alert (标题、信息、按钮数组、文本框个数、文本框和其编号、点击了那个按钮以及所有文本框的数组
- (void)AlertWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray<NSString *> *)buttons textFieldNumber:(NSInteger )number configuration:(configuration )configuration animated:(BOOL )animated action:(clickHaveField )click{
    if (fields == nil){
        fields = [NSMutableArray array];
    }else{
        [fields removeAllObjects];
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    // textfield
    for (NSInteger i = 0; i < number; i++){
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            [fields addObject:textField];
            configuration(textField,i);
        }];
    }
    // button
    [buttons enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0){
            [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (action){
                    click(fields,idx);
                }
            }]];
        }else{
            [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (action){
                    click(fields,idx);
                }
            }]];
        }
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController: alertController animated: YES completion: nil];
    });
}

#pragma mark- ActionSheet
//ActionSheet弹框（标题、信息、信息下面的信息(可为nil)、点击了按钮下面的信息、按钮title的数组、按钮的点击事件
- (void)ActionSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message destructive:(nullable NSString *)destructive destructiveAction:(click )destructiveAction andOthers:(NSArray <NSString *> *)others animated:(BOOL )animated action:(click )click{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    if (destructive){
        [alertController addAction:[UIAlertAction actionWithTitle:destructive style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (action){
                destructiveAction(-1000);
            }
        }]];
    }
    [others enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0){
            [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (action){
                    click(idx);
                }
            }]];
        }else{
            [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (action){
                    click(idx);
                }
            }]];
        }
    }];
    [self presentViewController:alertController animated:animated completion:nil];
}


@end
