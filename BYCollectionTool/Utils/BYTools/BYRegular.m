//
//  BYRegular.m
//  ZhiHuiLiJiang
//
//  Created by 胡忠诚 on 2018/11/19.
//  Copyright © 2018 WisdomLijiang. All rights reserved.
//正则表达式

#import "BYRegular.h"

@implementation BYRegular
//匹配1-11位数字
+ (BOOL)checkOneTenNumber:(NSString *)number{//无效
    NSString *passWordRegex = @"^[0-9]*$ ";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    
    return [passWordPredicate evaluateWithObject:number];
}

//匹配6位数字
+ (BOOL)checkSixNumber:(NSString *)number{
    NSString *passWordRegex = @"^\\d{6}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    
    return [passWordPredicate evaluateWithObject:number];
}

//匹配用户密码8-20位数字和字母组合
+ (BOOL)checkPassWord:(NSString *) passWord{
    NSString *passWordRegex = @"(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{8,20})$";//如果需要下划线或-,可修改成[a-zA-Z0-9_-]
    
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    
    return [passWordPredicate evaluateWithObject:passWord];
}

//匹配用户账号
+ (BOOL)checkUserId:(NSString *)userId{
    //社会化账号
    NSString *userIdRegex = @"^[A-Z0-9]{18}$";
    NSPredicate *userIdPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userIdRegex];
    
    return [userIdPredicate evaluateWithObject:userId] || [self valiMobile:userId];
}

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11){
        return NO;
    }else{
        NSString *CM_NUM = @"^1[3|4|5|7|8][0-9]\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        if (isMatch1) {
            return YES;
        }else{
            return NO;
        }
    }
}

//判断身份证格式是否正确
+ (BOOL)validateIDCardNumber:(NSString *)value {
    NSString *pattern = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:value];
    
    return isMatch;
}

+ (BOOL)checkBankCardNum:(NSString *)bankCardNumStr{//校验纯数字
    NSString * regex = @"[0-9]*";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isBankCardMatch = [pred evaluateWithObject:bankCardNumStr];
    return isBankCardMatch;
}



//手机号排空及正则校验
+ (NSString *)checkPhone:(NSString *)phoneStr{
    if (phoneStr.length == 0) {
        return @"请输入手机号！";
    }
    if (![BYRegular valiMobile:phoneStr]) {
        return @"手机号输入有误！";
    }
    return @"";
}
//密码排空及正则校验
+ (NSString *)checkPwd:(NSString *)pwdStr{
    if (pwdStr.length == 0) {
        return @"请输入密码!";
    }
    if (![BYRegular checkPassWord:pwdStr]) {
        return @"密码输入有误！";
    }
    return @"";
}
//验证码排空及正则校验
+ (NSString *)checkVeriCode:(NSString *)veriCodeStr{
    if (veriCodeStr.length == 0) {
        return @"请输入验证码！";
    }
    if (![BYRegular checkSixNumber:veriCodeStr]) {
        return @"验证码输入有误！";
    }
    return @"";
}
//支付密码排空及正则校验
+ (NSString *)checkPayPwd:(NSString *)veriCodeStr{
    if (veriCodeStr.length == 0) {
        return @"请输入密码！";
    }
    if (![BYRegular checkSixNumber:veriCodeStr]) {
        return @"密码输入有误！";
    }
    return @"";
}

//方法：字符串截取替换*（第几位后面开始、最后面留几位）
+ (NSString *)bbgSubstring:(NSString*)originalStr rlen:(NSInteger)rlen llen:(NSInteger)llen{
    int strlength = (int)originalStr.length;
    if (strlength <= 0) {
        return @"--";
    }
    if (strlength < (rlen + llen)) {
        return originalStr;
    }
    NSString* substr   = @"*";
    NSString* startstr = [originalStr substringToIndex:rlen];
    NSString* endstr   = [originalStr substringFromIndex:strlength - llen];
    NSInteger s = (strlength - rlen -llen);
    if (0 < s) {
        for (int i=0; i < s; i++) {
            substr = [NSString stringWithFormat:@"%@*",substr];
        }
    }
    substr = [substr substringToIndex:[substr length] -1];
    substr = [NSString stringWithFormat:@"%@%@%@",startstr,substr,endstr];
    return substr;
}
+ (NSArray *)jiequString:(NSString *)allStr bbStr:(NSString *)bbStr{//根据bbStr截取AllStr字符串，返回数组
    if ([allStr containsString:bbStr]){
        return [allStr componentsSeparatedByString:@"-"];
    }
    return @[];
}
//不同的时间formatter转换
+ (NSString *)dateStr:(NSString *)dateStr currentFromatter:(NSString *)cFStr nowFromatter:(NSString *)nFStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:cFStr];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    [dateFormatter setDateFormat:nFStr];
    dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}
//获取日期是周几
+ (NSString *)getCurrentDateWeekDay:(NSString *)currentDateStr{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setCalendar:calendar];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *nowDate = [formatter dateFromString:currentDateStr];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay fromDate:nowDate];
    // 得到星期几：1(星期天) 2(星期一) 3(星期二) 4(星期三) 5(星期四) 6(星期五) 7(星期六)
    NSInteger weekDay = [comp weekday];
//    NSLog(@"传入的日期：%@，是星期：%tu",currentDateStr,weekDay-1);
    NSString *currentWeekStr = @"";
    switch (weekDay) {
        case 1:
            currentWeekStr = @"星期日";
            break;
        case 2:
            currentWeekStr = @"星期一";
            break;
        case 3:
            currentWeekStr = @"星期二";
            break;
        case 4:
            currentWeekStr = @"星期三";
            break;
        case 5:
            currentWeekStr = @"星期四";
            break;
        case 6:
            currentWeekStr = @"星期五";
            break;
        case 7:
            currentWeekStr = @"星期六";
            break;
        default:
            break;
    }
    if ([calendar isDateInToday:nowDate]) {//判断是否是今天
        currentWeekStr = @"今天";
    }
    if ([calendar isDateInTomorrow:nowDate]) {//判断是否是明天
         currentWeekStr = @"明天";
    }
    return currentWeekStr;
}

+ (NSInteger)calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[endDate timeIntervalSinceDate:beginDate];
    int days=((int)time)/(3600*24);
    //int hours=((int)time)%(3600*24)/3600;
    //NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    return days + 1;
}

+(NSString *)getDateTimeFromMilliSeconds:(NSString *)str{//毫秒转换成时分秒
    NSInteger seconds = [str integerValue]/1000;
    NSString *h = [NSString stringWithFormat:@"%tu",seconds/3600];
    NSString *m = [NSString stringWithFormat:@"%tu",(seconds%3600)/60];
    NSString *s = [NSString stringWithFormat:@"%tu",seconds%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",h,m,s];
    return format_time;
}
    
    
@end
