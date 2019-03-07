//
//  BYVerificationCode.m
//  ZhiHuiLiJiang
//
//  Created by 胡忠诚 on 2018/11/20.
//  Copyright © 2018 WisdomLijiang. All rights reserved.
//验证码按钮

#import "BYVerificationCode.h"

@interface BYVerificationCode(){
    NSInteger _second;//当前秒数
    NSUInteger _totalSecond;//总秒数
    NSTimer *_timer;//定时器
    NSDate *_startDate;
}
//活动倒计时的属性
@property(nonatomic,retain) dispatch_source_t acTimer;
@property(nonatomic,retain) NSDateFormatter *dateFormatter;

@end
@implementation BYVerificationCode
#pragma mark- init初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = BYBlueColor2;
        [self setTitle:@"获取" forState:UIControlStateNormal];
        [self setTitleColor:BYWhiteColor1 forState:UIControlStateNormal];
        self.titleLabel.font = BYPTFont15;
    }
    return self;
}

#pragma mark- 用户交互
- (void)startCheckCodeCountdown:(NSUInteger)totalSecond{//开始倒计时
    _totalSecond = totalSecond;
    _second = totalSecond;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    _startDate = [NSDate date];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)timerStart:(NSTimer *)theTimer {//开启计时器
    double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    _second = _totalSecond - (NSInteger)(deltaTime+0.5) ;
    if (_second< 0.0){
        [self stopCountDown];
    }else{
//        [self setTitleColor:BYWhiteColor1 forState:UIControlStateNormal];
        [self setTitle:[NSString stringWithFormat:@"%lds|重新获取",(long)_second] forState:UIControlStateNormal];
    }
}
- (void)stopCountDown{//结束倒计时
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)]){
            if ([_timer isValid]){
                [_timer invalidate];
                _timer = nil;
                _second = _totalSecond;
                self.enabled = YES;
                self.backgroundColor = BYBlueColor2;
//                [self setTitleColor:BYWhiteColor1 forState:UIControlStateNormal];
                [self setTitle:@"重新获取" forState:UIControlStateNormal];
                NSLog(@"验证码的计时器销毁了");
            }
        }
    }
}
@end
