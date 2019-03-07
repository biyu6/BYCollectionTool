//
//  NSData+BYData.h
//  WallMeet
//
//  Created by 胡忠诚 on 2018/11/30.
//  Copyright © 2018 huaerjie. All rights reserved.
//压缩图片用

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (BYData)
//等比压缩图片质量和大小
+ (NSData *)zipImageWithImage:(UIImage *)image;


@end

NS_ASSUME_NONNULL_END
