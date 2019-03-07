//
//  NSData+BYData.m
//  WallMeet
//
//  Created by 胡忠诚 on 2018/11/30.
//  Copyright © 2018 huaerjie. All rights reserved.
//压缩图片用

#import "NSData+BYData.h"

@implementation NSData (BYData)
#pragma mark- 等比压缩图片质量和大小
+ (NSData *)zipImageWithImage:(UIImage *)image{//先压缩图片质量
    if (!image) {
        return nil;
    }
    CGFloat maxFileSize = 100*1024;//最大的图片为100kb
    CGFloat compression = 1.0f;
    NSData *compressedData = UIImageJPEGRepresentation(image, compression);
    //    NSLog(@"原图片大小为：%zd",[compressedData length]);
    while ([compressedData length] > maxFileSize) {
        compression *= 0.9;
        compressedData = UIImageJPEGRepresentation([NSData compressImage:image newWidth:image.size.width*compression], compression);
    }
    //    NSLog(@"压缩后图片大小为：%zd",[compressedData length]);
    return compressedData;
}
+ (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth{//再等比缩放图片大小
    if (!image) return nil;
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = newImageWidth;
    float height = image.size.height/(image.size.width/width);
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context,并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
