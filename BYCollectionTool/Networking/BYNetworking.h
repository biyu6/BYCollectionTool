//
//  BYNetworking.h
//  ZhiHuiLiJiang
//
//  Created by 胡忠诚 on 2018/11/19.
//  Copyright © 2018 WisdomLijiang. All rights reserved.
//网络请求

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**请求方式 GET OR POST*/
typedef enum HttpMethod {
    GET,
    POST,
    PUT
} httpMethod;

//返回数据解析成功
typedef void(^ BYAnalysisSuccess) (NSInteger code,NSString *msg,id data);
typedef void( ^ BYResponseSuccess)(id response);//返回整个数据
typedef void( ^ BYResponseFail)(NSError *error);//返回数据错误
typedef void( ^ BYUploadProgress)(int64_t bytesProgress,int64_t totalBytesProgress);
typedef void( ^ BYDownloadProgress)(int64_t bytesProgress,int64_t totalBytesProgress);
typedef NSURLSessionTask BYURLSessionTask;

@interface BYNetworking : NSObject
//是否有网络
+ (BOOL)isNoNetWorking;

/**post 或者 get 请求方法,block回调
 网络请求类型、接口名称、请求参数字典、loading的类型、请求成功的回调、请求失败的回调、是否显示HUD*/
+ (BYURLSessionTask *)requestGetOrPostWithType:(httpMethod)httpMethod url:(NSString *)urlStr params:(NSDictionary *)params success:(BYAnalysisSuccess)success fail:(BYResponseFail)fail showHUD:(BOOL)showHUD;

//上传图片(地址、参数、图片数组(NSData)、进度、上传成功、上传失败、是否显示遮罩层
+ (BYURLSessionTask *)uploadURL:(NSString *)url params:(NSDictionary *)dict imageArr:(NSArray *)imgArr progress:(BYUploadProgress)progress  success:(BYAnalysisSuccess)success fail:(BYResponseFail)fail showHUD:(BOOL)showHUD;


@end

NS_ASSUME_NONNULL_END
