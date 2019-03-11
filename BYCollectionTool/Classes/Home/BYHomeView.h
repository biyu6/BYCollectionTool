//
//  BYHomeView.h
//  OnlineEdu
//
//  Created by biyu6 on 2019/3/5.
//  Copyright © 2019 cameroon. All rights reserved.
//首页View

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BYHomeView : UIImageView
/**点击了第一个按钮*/
@property(nonatomic,copy)void (^clickOneBtn)(void);
/**点击了第二个按钮*/
@property(nonatomic,copy)void (^clickTwoBtn)(void);
/**点击了第三个按钮*/
@property(nonatomic,copy)void (^clickThreeBtn)(void);
/**点击了第四个按钮*/
@property(nonatomic,copy)void (^clickFourBtn)(void);

@end

NS_ASSUME_NONNULL_END
