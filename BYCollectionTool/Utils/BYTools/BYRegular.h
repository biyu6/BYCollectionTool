//
//  BYRegular.h
//  ZhiHuiLiJiang
//
//  Created by 胡忠诚 on 2018/11/19.
//  Copyright © 2018 WisdomLijiang. All rights reserved.
//正则表达式

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BYRegular : NSObject
//匹配1-10位数字
+ (BOOL)checkOneTenNumber:(NSString *)number;

//匹配6位数字
+ (BOOL)checkSixNumber:(NSString *)number;

//匹配用户密码8-20位数字和字母组合
+ (BOOL)checkPassWord:(NSString *) passWord;

//匹配用户账号
+ (BOOL)checkUserId:(NSString *)userId;

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile;

//判断身份证格式是否正确
+ (BOOL)validateIDCardNumber:(NSString *)value;
//校验纯数字
+ (BOOL)checkBankCardNum:(NSString *)bankCardNumStr;

//手机号排空及正则校验
+ (NSString *)checkPhone:(NSString *)phoneStr;
//密码排空及正则校验
+ (NSString *)checkPwd:(NSString *)pwdStr;
//验证码排空及正则校验
+ (NSString *)checkVeriCode:(NSString *)veriCodeStr;
//支付密码排空及正则校验
+ (NSString *)checkPayPwd:(NSString *)veriCodeStr;

//方法：字符串截取替换*（第几位后面开始、最后面留几位）
+ (NSString *)bbgSubstring:(NSString*)originalStr rlen:(NSInteger)rlen llen:(NSInteger)llen;
//根据bbStr截取AllStr字符串，返回数组
+ (NSArray *)jiequString:(NSString *)allStr bbStr:(NSString *)bbStr;
//不同的时间formatter转换
+ (NSString *)dateStr:(NSString *)dateStr currentFromatter:(NSString *)cFStr nowFromatter:(NSString *)nFStr;
//获取日期是周几
+ (NSString *)getCurrentDateWeekDay:(NSString *)currentDateStr;
//获取两个日期之间的天数数量
+ (NSInteger)calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate;
//毫秒转换成时分秒
+(NSString *)getDateTimeFromMilliSeconds:(NSString *)str;


@end

NS_ASSUME_NONNULL_END
