//
//  BYHubView.h
//  WallMeet
//
//  Created by 胡忠诚 on 2018/12/6.
//  Copyright © 2018 huaerjie. All rights reserved.
//无结果页View

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BYHubView : UIView
/**图片名*/
@property(nonatomic,copy)NSString *promptImgStr;

/**提示刷新控制器请求*/
@property (nonatomic, copy)void (^promptUploadVCRequest)(void);

- (void)hiddenHubView;

@end

NS_ASSUME_NONNULL_END
