//
//  UIView+MJAlertView.h
//  ZhiHuiLiJiang
//
//  Created by 胡忠诚 on 2018/11/20.
//  Copyright © 2018 WisdomLijiang. All rights reserved.
//吐丝框

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^getPictureDataBlock)(NSDictionary *dic);
@interface UIView (MJAlertView)<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
#pragma mark- 获取当前View的控制器
- (UIViewController *)getBYCurrentVC;

#pragma mark- 上传图片
- (void)changeAndUploadIconParams:(NSDictionary *)dic btnClickBlock:(getPictureDataBlock)complete;//点击了头像


#pragma mark- 吐丝框
+ (void) addMJNotifierWithText : (NSString* ) text dismissAutomatically : (BOOL) shouldDismiss;
+ (void) dismissMJNotifier;


@end

NS_ASSUME_NONNULL_END
