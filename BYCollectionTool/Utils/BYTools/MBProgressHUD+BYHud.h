//
//  MBProgressHUD+BYHud.h
//  ZhiHuiLiJiang
//
//  Created by 胡忠诚 on 2018/11/19.
//  Copyright © 2018 WisdomLijiang. All rights reserved.
//遮罩

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (BYHud)
/**信息提示(提示文字、HUD展示的view、展示的时间）*/
+ (MBProgressHUD *)showInformation:(NSString *)information toView:(UIView *)view andAfterDelay:(float)afterDelay;

/**自定义view、提示文字、HUD展示的view、展示时间*/
+ (void)showCustomview:(UIView *)customview andTextString:(NSString *)textString toView:(UIView *)view andAfterDelay:(float)afterDelay;

/**隐藏 HUD*/
+ (void) dissmissShowView:(UIView *)showView;

/**显示 HUD（iamgeArr 为 loading 图片数组，如果为nil 则为默认的loading样式）*/
+ (instancetype) showHUDWithImageArr:(NSMutableArray *)imageArr andShowView:(UIView *)showView;

//显示信息和信息上的model，并指定是在window上展示还是在当前控制器的View上展示
+ (void)showMessage:(NSString *)message MBPMode:(MBProgressHUDMode )mode isWindiw:(BOOL)isWindow;


//隐藏window上的HUD
+ (void)dissmissWindowHud;
//显示window上的HUD
+ (instancetype)showWindowHUD;
//在keywindow上显示提示文字 和展示时间
+ (MBProgressHUD *)showStringWithKeyWindow:(NSString *)information andAfterDelay:(float)afterDelay;

@end

NS_ASSUME_NONNULL_END
