//
//  BYNoPasteTF.m
//  Unity-iPhone
//
//  Created by 胡忠诚 on 2018/8/14.
//禁止粘贴的TextField

#import "BYNoPasteTF.h"

@implementation BYNoPasteTF
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if(menuController) {
        [UIMenuController sharedMenuController].menuVisible=NO;
    }
    return NO;
}


@end
