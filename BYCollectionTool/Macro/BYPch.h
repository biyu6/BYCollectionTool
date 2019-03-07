//
//  BYPch.h
//  WallMeet
//
//  Created by 胡忠诚 on 2018/11/26.
//  Copyright © 2018 huaerjie. All rights reserved.
//BY的pch文件

#ifndef BYPch_h
#define BYPch_h

//打印
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);//将打印内容前的时间戳，改为类名：行号
#else
#define NSLog(...)
#endif

//设备
#define BYIS_PHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define BYIS_PAD   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

//版本
#define BYSYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//弱引用
#define BYkWeakSelf(weakSelf) __weak __typeof(&*self) weakSelf = self;

//屏幕宽高
#define BYScreenHeight [UIScreen mainScreen].bounds.size.height
#define BYScreenWidth [UIScreen mainScreen].bounds.size.width

//app版本
#define BYAPP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
//iphone 宽度 、高度、字体大小
#define BYFontSize(PT) [UIFont systemFontOfSize:(PT*(BYScreenWidth/375.f))]
#define BYBoldFontSize(PT) [UIFont boldSystemFontOfSize:(PT*(BYScreenWidth/375.f))]
#define BYWidth(width) ((BYScreenWidth/(375.f)) * (width))
#define BYHeight(height) ((BYScreenHeight/(667.f)) * (height))

 #define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//iPhoneX相关
#define BYiPhoneXorXs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define BYiPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define BYiPhoneXMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define BYIS_iPhoneX (BYiPhoneXorXs || BYiPhoneXr || BYiPhoneXMax)
#define BYStatusBar_H (BYIS_iPhoneX ? 44 : 20)
#define BYNav_H (BYIS_iPhoneX ? 88 : 64)
#define BYBot_H (BYIS_iPhoneX ? 34 : 0)
#define BYNavBot_H (BYIS_iPhoneX ? 122 : 64)


//沙盒路径
#define BYPATHDire_Home    NSHomeDirectory()
#define BYPATHDire_Temp        NSTemporaryDirectory()
#define BYPATHDire_Document    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//排空
#define BYSafeStr(f) (BYStrValid(f) ? f:@"")//获取到一个安全的字符串
#define BYStrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])//判断是否是一个有效的字符串
#define BYHasString(str,eky) ([str rangeOfString:key].location!=NSNotFound)//判断在字符串str中有没有eky
#define BYSafeDict(f) (BYValidDict(f) ? f : @{})//获取一个安全的字典
#define BYValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])//判断是否是一个有效的字典
#define BYValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)//判断是否是一个有效的数组
#define BYSafeNum(f) (BYValidNum(f) ? f : @-101) //获取到一个安全的NSNumber
#define BYValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])//判断是否是一个有效的NSNumber
#define BYValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])//判断是否是一个有效的类
#define BYValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])//判断是否是一个有效的NSData

//完美单例的 声明BYSingtonH 与实现BYSingtonM (alloc、new、shareName、copy、mutableCopy)
#define BYSingtonH(name) +(instancetype)share##name;
#define BYSingtonM(name) static id _instance;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
+ (instancetype)share##name{\
return [[self alloc]init];\
}\
- (id)copyWithZone:(NSZone *)zone{\
return _instance;\
}\
- (id)mutableCopyWithZone:(NSZone *)zone{\
return _instance;\
}\

//颜色
#define BYClearColor [UIColor clearColor]
#define BYRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0f green:arc4random_uniform(256)/255.0f blue:arc4random_uniform(256)/255.0f alpha:1.0]//随机色
#define BYRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]//BYRGBA(51,51,51,1)

#define BYRedColor1 [UIColor redColor]
#define BYCyanColor1 [UIColor cyanColor]
#define BYOrangeColor1 [UIColor orangeColor]

#define BYBlackColor1 [UIColor blackColor] //黑色
#define BYBlackColor2 [UIColor grayColor] //灰色
#define BYBlackColor3 [UIColor lightGrayColor] //亮灰色
#define BYBlackColor4 BYRGBA(204,204,204,1.0)  //tabBar灰色
#define BYBlackColor5 BYRGBA(89,87,87,1.0)  //首页目的地灰色
#define BYBlackColor6 BYRGBA(159, 160, 160, 1.0) //首页今天灰色
#define BYBlackColor7 BYRGBA(239, 239, 244, 1.0) //tableView背景颜色
#define BYBlackColor8 BYRGBA(62,58,57,1.0)  //欢迎您

#define BYWhiteColor1 [UIColor whiteColor] //白色

#define BYBlueColor1 [UIColor blueColor] //蓝色
#define BYBlueColor2 BYRGBA(16, 81, 255, 1.0) //首页天数下划线蓝色
#define BYBlueColor3 BYRGBA(16, 81, 255, 0.5) //半透明的蓝色
#define BYBlueColor4 BYRGBA(16, 81, 255, 0.03) //透明蓝色


#define BYYellowColor1 [UIColor yellowColor] //黄色
#define BYYellowColor2 BYRGBA(255, 206, 0, 1.0) //和他聊聊

//字体
#define BYPTFont10 BYFontSize(10)
#define BYPTFont11 BYFontSize(11)
#define BYPTFont12 BYFontSize(12)
#define BYPTFont13 BYFontSize(13)
#define BYPTBoldFont13 BYBoldFontSize(13)
#define BYPTFont14 BYFontSize(14)
#define BYPTFont15 BYFontSize(15)
#define BYPTBoldFont15 BYBoldFontSize(15)
#define BYPTFont16 BYFontSize(16)
#define BYPTFont17 BYFontSize(17)
#define BYPTBoldFont17 BYBoldFontSize(17)
#define BYPTFont18 BYFontSize(18)
#define BYPTFont19 BYFontSize(19)
#define BYPTFont20 BYFontSize(20)
#define BYPTBoldFont20 BYBoldFontSize(20)
#define BYPTFont21 BYFontSize(21)
#define BYPTFont22 BYFontSize(22)
#define BYPTFont23 BYFontSize(23)
#define BYPTFont24 BYFontSize(24)
#define BYPTBoldFont26 BYBoldFontSize(26)
#define BYPTFont26 BYFontSize(26)
#define BYPTFont28 BYFontSize(28)
#define BYPTFont29 BYFontSize(29)
#define BYPTFont30 BYFontSize(30)
#define BYPTFont32 BYFontSize(32)
#define BYPTFont34 BYFontSize(34)
#define BYPTBoldFont34 BYBoldFontSize(34)
#define BYPTFont36 BYFontSize(36)
#define BYPTBoldFont36 BYBoldFontSize(36)
#define BYPTFont40 BYFontSize(40)
#define BYPTFont60 BY_FontSize(60)



#endif /* BYPch_h */
