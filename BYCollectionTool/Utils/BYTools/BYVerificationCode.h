//
//  BYVerificationCode.h
//  ZhiHuiLiJiang
//
//  Created by 胡忠诚 on 2018/11/20.
//  Copyright © 2018 WisdomLijiang. All rights reserved.
//验证码按钮

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BYVerificationCode : UIButton
//开始验证码的倒计时
- (void)startCheckCodeCountdown:(NSUInteger)second;

//停止验证码的倒计时
- (void)stopCountDown;


@end

NS_ASSUME_NONNULL_END
