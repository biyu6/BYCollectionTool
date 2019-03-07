//
//  BYNetworking.m
//  ZhiHuiLiJiang
//
//  Created by 胡忠诚 on 2018/11/19.
//  Copyright © 2018 WisdomLijiang. All rights reserved.
//网络请求

#import "BYNetworking.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "YYReachability.h"//网络状态

static NSMutableArray *tasks;
@implementation BYNetworking
+ (NSMutableArray *)tasks{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tasks = [[NSMutableArray alloc] init];
    });
    return tasks;
}
//post或者get请求
+ (BYURLSessionTask *)requestGetOrPostWithType:(httpMethod)httpMethod url:(NSString *)urlStr params:(NSDictionary *)params success:(BYAnalysisSuccess)success fail:(BYResponseFail)fail showHUD:(BOOL)showHUD{
    //判断是否有网络链接
    if ([self isNoNetWorking]) {
        [MBProgressHUD showStringWithKeyWindow:@"网络无连接，请检查网络" andAfterDelay:3.0];
        if (fail) {
            NSError *error = nil;
            fail(error);
        }
        return nil;
    }
    urlStr = [NSString stringWithFormat:@"%@%@",MAINURL,urlStr];
    return [self baseRequestType:httpMethod url:urlStr params:params success:success fail:fail showHUD:showHUD];
}
+ (BYURLSessionTask *)baseRequestType:(httpMethod)type url:(NSString *)url params:(NSDictionary *)params success:(BYAnalysisSuccess)success fail:(BYResponseFail)fail showHUD:(BOOL)showHUD {
    if (url==nil) {
        return nil;
    }
    if (showHUD == YES) {
        [MBProgressHUD dissmissWindowHud];
        [MBProgressHUD showWindowHUD];
    }
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    AFHTTPSessionManager *manager=[self getAFManager];
    BYURLSessionTask *sessionTask=nil;
    if (type== GET) {
        sessionTask = [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"GET请求成功的返回值：%@",responseObject);
            //解析数据
            [self analysisData:responseObject withUrl:url withSuccess:success];
            [[self tasks] removeObject:sessionTask];
            if (showHUD==YES) {
                [MBProgressHUD dissmissWindowHud];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (errorData != nil) {
                NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
                NSLog(@"GET_failure:==%@,具体错误：%@",error,serializedData);
            }
            if (fail) {
                fail(error);
            }
            [[self tasks] removeObject:sessionTask];
            if (showHUD==YES) {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    sleep(1.0);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD dissmissWindowHud];
                    });
                });
            }
        }];
    }else if(type== PUT) {
        sessionTask = [manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"PUT请求成功的返回值：%@",responseObject);
            //解析数据
            [self analysisData:responseObject withUrl:url withSuccess:success];
            [[self tasks] removeObject:sessionTask];
            if (showHUD==YES) {
                [MBProgressHUD dissmissWindowHud];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (errorData != nil) {
                NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
                NSLog(@"PUT_failure:==%@,具体错误：%@",error,serializedData);
            }
            if (fail) {
                fail(error);
            }
            [[self tasks] removeObject:sessionTask];
            if (showHUD==YES) {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    sleep(1.0);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD dissmissWindowHud];
                    });
                });
            }
        }];
    }else{//POST
        sessionTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //            NSLog(@"POST请求成功的返回值：%@",responseObject);
            //解析数据
            [self analysisData:responseObject withUrl:url withSuccess:success];
            [[self tasks] removeObject:sessionTask];
            if (showHUD==YES) {
                [MBProgressHUD dissmissWindowHud];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (errorData != nil) {
                NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
                NSLog(@"POST_failure:==%@,具体错误：%@",error,serializedData);
            }
            if (fail) {
                fail(error);
            }
            [[self tasks] removeObject:sessionTask];
            if (showHUD==YES) {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    sleep(1.0);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD dissmissWindowHud];
                    });
                });
            }
        }];
    }
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    return sessionTask;
}
//解析返回值
+ (void)analysisData:(id )response withUrl:(NSString *)urlStr withSuccess:(BYAnalysisSuccess)success{
    NSLog(@"%@--获取到的返回值：%@",urlStr,response);//0成功、-1失败、-2（message提示用户）
    NSString *codeStr = [response objectForKey:@"code"];
    NSString *msgStr = BYSafeStr([response objectForKey:@"message"]);
    if ([codeStr isEqualToString:@"0"]) {
        id resultData = [response objectForKey:@"data"];
        success(0,msgStr,resultData);
    }else{//错误
        NSLog(@"网络请求错误：%@",msgStr);
        [UIView addMJNotifierWithText:@"网络请求失败!" dismissAutomatically:YES];
        success([codeStr integerValue],msgStr,@"");
    }
}

//网络请求的配置
+ (AFHTTPSessionManager *)getAFManager{
    static AFHTTPSessionManager *httpManager = nil;
    //一般配置只执行一次就行，但后台要求在每次的请求头上都要配置上token,所以不能用dispatch_once了
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        httpManager = [AFHTTPSessionManager manager];
//        [httpManager setSecurityPolicy:[BYNetworking customSecurityPolicy]];//设置https证书
        //请求的数据格式：AFJSONRequestSerializer、AFHTTPRequestSerializer；后台选择的是json
        AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
        httpManager.requestSerializer = requestSerializer;
    //设置返回的格式
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
//        response.removesKeysWithNullValues = YES;//利用AFNetworking的自动解析，去除掉值为null的键值对
//        [httpManager.requestSerializer setValue:@"gzip"forHTTPHeaderField:@"Accept-Encoding"];
//        [httpManager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
        httpManager.responseSerializer = response;//设置返回数据为json
        httpManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        httpManager.requestSerializer.timeoutInterval= 130;
        httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    });
    return httpManager;
}
//导入HTTPs证书
+ (AFSecurityPolicy*)customSecurityPolicy{
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"yop" ofType:@"der"];//准生产、生产证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    NSSet *certSet = [NSSet setWithObject:certData];
    //AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
    //是否允许无效证书（也就是自建的证书），默认为NO；如果是需要验证自建证书，需要设置为YES
    policy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为yes；假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。如置为NO，建议自己添加对应域名的校验逻辑。
    policy.validatesDomainName = NO;//是否校验证书上域名与请求域名一致
    return policy;
}

//是否有网络
+ (BOOL)isNoNetWorking{
   return [[self getNetworkState] isEqualToString:@"NoNetWork"];
}
//获取网络状态
+ (NSString *)getNetworkState{
    NSString *networkStateStr = @"";
    YYReachability *conn = [YYReachability reachability];
    if (conn.status == YYReachabilityStatusNone) {//无网络
        networkStateStr = @"NoNetWork";
    } else if (conn.status == YYReachabilityStatusWWAN) {//手机网络
        if (conn.wwanStatus == YYReachabilityWWANStatus2G) {
            networkStateStr = @"2G";
        }else if (conn.wwanStatus == YYReachabilityWWANStatus3G) {
            networkStateStr = @"3G";
        }else if (conn.wwanStatus == YYReachabilityWWANStatus4G) {
            networkStateStr = @"4G";
        }else{
            networkStateStr = @"NOWWAN";
        }
    }else if (conn.status == YYReachabilityStatusWiFi){//WIFI
        networkStateStr = @"WIFI";
    }else{//未知网络
        networkStateStr = @"UnknownNetWork";
    }
//    NSLog(@"网络类型：%@",networkStateStr);
    return networkStateStr;
}
+ (NSString *)strUTF8Encoding:(NSString *)str{
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}
- (void)dealloc{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

//下载文件方法（暂未用）
+ (BYURLSessionTask *)downloadWithUrl:(NSString *)url saveToPath:(NSString *)saveToPath loadingImageArr:(NSMutableArray *)loadingImageArr progress:(BYDownloadProgress )progressBlock success:(BYResponseSuccess )success failure:(BYResponseFail )fail showHUD:(BOOL)showHUD{
    if (url==nil) {
        return nil;
    }
    if (showHUD==YES) {
        [MBProgressHUD showWindowHUD];
    }
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [self getAFManager];
    BYURLSessionTask *sessionTask = nil;
    sessionTask = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"下载进度--%.1f",1.0 * downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressBlock) {
                progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!saveToPath) {
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSLog(@"默认路径--%@",downloadURL);
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
        }else{
            NSURL *downloadURL = [NSURL fileURLWithPath:saveToPath];
            NSLog(@"目标下载路径--%@",downloadURL);
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[self tasks] removeObject:sessionTask];
        if (error == nil) {
            if (success) {
                success([filePath path]);//返回完整路径
            }
        } else {
            if (fail) {
                fail(error);
            }
        }
        if (showHUD==YES) {
            [MBProgressHUD dissmissWindowHud];
        }
    }];
    //开始下载
    [sessionTask resume];
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    return sessionTask;
}


//上传图片(地址、参数、图片数组(NSData)、进度、上传成功、上传失败、是否显示遮罩层
+ (BYURLSessionTask *)uploadURL:(NSString *)url params:(NSDictionary *)dict imageArr:(NSArray *)imgArr progress:(BYUploadProgress)progress  success:(BYAnalysisSuccess)success fail:(BYResponseFail)fail showHUD:(BOOL)showHUD{
    if (url==nil) {
        return nil;
    }
    if (showHUD == YES) {
        [MBProgressHUD dissmissWindowHud];
        [MBProgressHUD showWindowHUD];
    }
    //检查地址中是否有中文
    url = [NSString stringWithFormat:@"%@%@",MAINURL,url];
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    //请求
    AFHTTPSessionManager *manager=[self getAFManager];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
//    manager.requestSerializer.timeoutInterval= 30;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain",@"text/xml",@"image/*", nil];
    BYURLSessionTask *sessionTask=nil;
    sessionTask = [manager POST:urlStr parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < imgArr.count; ++i) {
            // 设置时间格式
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            NSData *imgData = [NSData zipImageWithImage:imgArr[i]];
            [formData appendPartWithFileData:imgData name:@"file" fileName:fileName mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //解析数据
        [self analysisData:responseObject withUrl:url withSuccess:success];
        [[self tasks] removeObject:sessionTask];
        if (showHUD==YES) {
            [MBProgressHUD dissmissWindowHud];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (errorData != nil) {
            NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
            NSLog(@"上传图片_failure:==%@,具体错误：%@",error,serializedData);
        }
        if (fail) {
            fail(error);
        }
        [[self tasks] removeObject:sessionTask];
        if (showHUD==YES) {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                sleep(1.0);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD dissmissWindowHud];
                });
            });
        }
    }];
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    return sessionTask;
}



@end
