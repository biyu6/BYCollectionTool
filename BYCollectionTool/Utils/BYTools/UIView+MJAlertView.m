//
//  UIView+MJAlertView.m
//  ZhiHuiLiJiang
//
//  Created by 胡忠诚 on 2018/11/20.
//  Copyright © 2018 WisdomLijiang. All rights reserved.
//吐丝框

#import "UIView+MJAlertView.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

#define BYMJAPPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define NOTIFIER_LABEL_FONT ([UIFont fontWithName:@"HelveticaNeue-Light" size:18])
#define NOTIFIER_CANCEL_FONT ([UIFont fontWithName:@"HelveticaNeue" size:13])

static const NSInteger kTagMJAlertView = 1812;
static const NSInteger xPadding = 18.0;
static const CGFloat kLabelHeight = 45.0f;
static const CGFloat kCancelButtonHeight = 30.0f;
static const CGFloat kSeparatorHeight = 1.0f;
static const CGFloat kHeightFromBottom = 70.f;
static const CGFloat kMaxWidth = 290.0f;

static getPictureDataBlock currentPicBlock = nil;
NSDictionary *_iconParams;
@implementation UIView (MJAlertView)
#pragma mark- 获取当前View的控制器
- (UIViewController *)getBYCurrentVC{//获取当前View的控制器
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

#pragma mark- 上传图片
- (void)changeAndUploadIconParams:(NSDictionary *)dic btnClickBlock:(getPictureDataBlock)complete{//点击了头像
    BYkWeakSelf(ws);
    _iconParams = dic;
    [[self getBYCurrentVC] ActionSheetWithTitle:nil message:nil destructive:nil destructiveAction:^(NSInteger index) {
    } andOthers:@[@"取消",@"拍照",@"从手机相册选择"] animated:YES action:^(NSInteger index) {
        [ws choicePickerControllerSourceTypeWithIndex:index btnClickBlock:complete];
    }];
}
- (void)choicePickerControllerSourceTypeWithIndex:(NSInteger )index btnClickBlock:(getPictureDataBlock)complete{//选择了照片渠道
    if (index != 0) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        //            imagePicker.allowsEditing = YES;
        if (index == 1) {//拍照
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//读取设备授权状态
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){//限制、拒绝
                [[self getBYCurrentVC] AlertWithTitle:@"华尔街-需要在设置头像时使用到您的相机" message:@"请在iPhone的“设置->隐私->相机”选项中，允许华尔街访问您的相机。" andOthers:@[@"不允许",@"去设置"] animated:YES action:^(NSInteger index) {
                    if (index==1) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    }
                }];
                return;
            }
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }else{//相册选择
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        currentPicBlock = complete;
        [[self getBYCurrentVC] presentViewController:imagePicker animated:YES completion:nil];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = info[@"UIImagePickerControllerOriginalImage"];
    //上传图片
    [BYNetworking uploadURL:INTNAME_uploadPic params:_iconParams imageArr:@[img] progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
//        NSLog(@"上传图片-进度:%lld,总进度---%lld",bytesProgress,totalBytesProgress);
    } success:^(NSInteger code, NSString * _Nonnull msg, id  _Nonnull data) {
//        NSLog(@"上传图片-成功:%tu--%@--%@",code,msg,data);
        NSDictionary *iconDic = data;
        if (currentPicBlock) {
            currentPicBlock(iconDic);
        }
        currentPicBlock = nil;
        
    } fail:^(NSError * _Nonnull error) {
        NSLog(@"上传图片-失败:%@",error);
    } showHUD:YES];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{//系统--取消自拍及照片选择
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- 吐丝框
+ (void) addMJNotifierWithText : (NSString* ) text dismissAutomatically : (BOOL) shouldDismiss {
    //get screen area
    CGRect screenBounds = BYMJAPPDELEGATE.window.bounds;
    
    //get width for given text
    NSDictionary *attributeDict = @{NSFontAttributeName : NOTIFIER_LABEL_FONT};
    CGFloat height = kLabelHeight;
    CGFloat width = CGFLOAT_MAX;
    CGRect notifierRect = [text boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDict context:NULL];
    
    //get xoffset width for the notifier view
    CGFloat notifierWidth = MIN(CGRectGetWidth(notifierRect) + 2*xPadding, kMaxWidth);
    CGFloat xOffset = (CGRectGetWidth(screenBounds) - notifierWidth)/2;
    
    //get height for notifier view.. Add cancel button height if not dismissing automatically
    NSInteger notifierHeight = kLabelHeight;
    if(!shouldDismiss) {
        notifierHeight += (kCancelButtonHeight+kSeparatorHeight);
    }
    
    //get yOffset for notifier view
    CGFloat yOffset = CGRectGetHeight(screenBounds) - notifierHeight - kHeightFromBottom;
    
    CGRect finalFrame = CGRectMake(xOffset, yOffset, notifierWidth, notifierHeight);
    
    UIView* notifierView = [self checkIfNotifierExistsAlready];
    if(notifierView) {
        //update the existing notification here
        [self updateNotifierWithAnimation:notifierView withText:text completion:^(BOOL finished) {
            CGRect atLastFrame = finalFrame;
            atLastFrame.origin.y = finalFrame.origin.y + 8;
            notifierView.frame = atLastFrame;
            
            //get the label and update its text and frame!
            UILabel* textLabel = nil;
            for (UIView* subview in notifierView.subviews) {
                if([subview isKindOfClass:[UILabel class]]) {
                    textLabel = (UILabel* ) subview;
                }
                
                //also remove separator and "cancel" button.. we may add it later if necessary
                if([subview isKindOfClass:[UIImageView class]] || [subview isKindOfClass:[UIButton class]]) {
                    [subview removeFromSuperview];
                }
            }
            textLabel.text = text;
            textLabel.frame = CGRectMake(xPadding, 0.0, notifierWidth - 2*xPadding, kLabelHeight);
            
            //if not dismissing
            if(!shouldDismiss) {
                //first show a separator
                UIImageView* separatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, CGRectGetHeight(textLabel.frame), CGRectGetWidth(notifierView.frame), kSeparatorHeight)];
                [separatorImageView setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5]];
                [notifierView addSubview:separatorImageView];
                
                //now add that cancel button
                UIButton* buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
                buttonCancel.frame = CGRectMake(0.0, CGRectGetMaxY(separatorImageView.frame), CGRectGetWidth(notifierView.frame), kCancelButtonHeight);
                [buttonCancel setBackgroundColor:UIColorFromRGB(0x000000)];
                [buttonCancel addTarget:self action:@selector(buttonCancelClicked:) forControlEvents:UIControlEventTouchUpInside];
                [buttonCancel setTitle:@"Cancel" forState:UIControlStateNormal];
                buttonCancel.titleLabel.font = NOTIFIER_CANCEL_FONT;
                [notifierView addSubview:buttonCancel];
            }
            
            [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                notifierView.alpha = 1;
                notifierView.frame = finalFrame;
            } completion:^(BOOL finished) {
            }];
        }];
        
        if(shouldDismiss) {
            [self performSelector:@selector(dismissMJNotifier) withObject:nil afterDelay:2.0];
        }
    }
    else {
        notifierView = [[UIView alloc] initWithFrame:CGRectMake(xOffset, CGRectGetHeight(screenBounds), notifierWidth, notifierHeight)];
        notifierView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        notifierView.tag = kTagMJAlertView;
        notifierView.clipsToBounds = YES;
        notifierView.layer.cornerRadius = 5.0;
        [BYMJAPPDELEGATE.window addSubview:notifierView];
        [BYMJAPPDELEGATE.window bringSubviewToFront:notifierView];
        
        //create label which holds text inside the notifier view
        UILabel* textLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPadding, 0.0, notifierWidth - 2*xPadding, kLabelHeight)];
        textLabel.adjustsFontSizeToFitWidth = YES;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = UIColorFromRGB(0xFFFFFF);
        textLabel.font = NOTIFIER_LABEL_FONT;
        textLabel.minimumScaleFactor = 0.7;
        textLabel.numberOfLines = 0;
        textLabel.text = text;
        [notifierView addSubview:textLabel];
        
        if(shouldDismiss) {
            [self performSelector:@selector(dismissMJNotifier) withObject:nil afterDelay:2.0];
        }
        else {
            //not dismissng automatically... show cancel button to dismiss this alert
            
            //first show a separator
            UIImageView* separatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, CGRectGetHeight(textLabel.frame), notifierWidth, kSeparatorHeight)];
            [separatorImageView setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5]];
            [notifierView addSubview:separatorImageView];
            
            //now add that cancel button
            UIButton* buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonCancel.frame = CGRectMake(0.0, CGRectGetMaxY(separatorImageView.frame), notifierWidth, kCancelButtonHeight);
            [buttonCancel setBackgroundColor:UIColorFromRGB(0x000000)];
            [buttonCancel addTarget:self action:@selector(buttonCancelClicked:) forControlEvents:UIControlEventTouchUpInside];
            [buttonCancel setTitle:@"Cancel" forState:UIControlStateNormal];
            buttonCancel.titleLabel.font = NOTIFIER_CANCEL_FONT;
            [notifierView addSubview:buttonCancel];
        }
        
        [self startEntryAnimation:notifierView withFinalFrame:finalFrame];
    }
}

+ (UIView* ) checkIfNotifierExistsAlready {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissMJNotifier) object:nil];
    
    UIView* notifier = nil;
    for (UIView* subview in [BYMJAPPDELEGATE.window subviews]) {
        if(subview.tag == kTagMJAlertView && [subview isKindOfClass:[UIView class]]) {
            notifier = subview;
        }
    }
    
    return notifier;
}

+ (void) dismissMJNotifier {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissMJNotifier) object:nil];
    
    UIView* notifier = nil;
    
    for (UIView* subview in [BYMJAPPDELEGATE.window subviews]) {
        if(subview.tag == kTagMJAlertView && [subview isKindOfClass:[UIView class]]) {
            notifier = subview;
        }
    }
    
    [self startExitAnimation:notifier];
}

+ (void) buttonCancelClicked : (id) sender {
    [self dismissMJNotifier];
}

#pragma mark - Animation part
+ (void) updateNotifierWithAnimation : (UIView* ) notifierView withText : (NSString* ) text completion:(void (^)(BOOL finished))completion {
    CGRect finalFrame = notifierView.frame;
    finalFrame.origin.y = finalFrame.origin.y + 8;
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        notifierView.alpha = 0;
        notifierView.frame = finalFrame;
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}

+ (void) startEntryAnimation : (UIView* ) notifierView withFinalFrame : (CGRect) finalFrame {
    
    CGFloat finalYOffset = finalFrame.origin.y;
    finalFrame.origin.y = finalFrame.origin.y - 15;
    
    CATransform3D transform = [self transformWithXAxisValue:-0.1 andAngle:45];
    notifierView.layer.zPosition = 400;
    notifierView.layer.transform = transform;
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        notifierView.frame = finalFrame;
        
        CATransform3D transform = [self transformWithXAxisValue:0.1 andAngle:15];
        notifierView.layer.zPosition = 400;
        notifierView.layer.transform = transform;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect atLastFrame = finalFrame;
            atLastFrame.origin.y = finalYOffset;
            notifierView.frame = atLastFrame;
            
            CATransform3D transform = [self transformWithXAxisValue:0.0 andAngle:90];
            notifierView.layer.zPosition = 400;
            notifierView.layer.transform = transform;
            
        } completion:^(BOOL finished) {
        }];
    }];
}

+ (void) startExitAnimation : (UIView* ) notifierView {
    
    //get screen area
    CGRect screenBounds = BYMJAPPDELEGATE.window.bounds;
    
    CGRect notifierFrame = notifierView.frame;
    CGFloat finalYOffset = notifierFrame.origin.y - 12;
    notifierFrame.origin.y = finalYOffset;
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        notifierView.frame = notifierFrame;
        
        CATransform3D transform = [self transformWithXAxisValue:0.1 andAngle:30];
        notifierView.layer.zPosition = 400;
        notifierView.layer.transform = transform;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect atLastFrame = notifierView.frame;
            atLastFrame.origin.y = CGRectGetHeight(screenBounds);
            notifierView.frame = atLastFrame;
            
            CATransform3D transform = [self transformWithXAxisValue:-1 andAngle:90];
            notifierView.layer.zPosition = 400;
            notifierView.layer.transform = transform;
            
        } completion:^(BOOL finished) {
            [notifierView removeFromSuperview];
        }];
    }];
}

+ (CATransform3D) transformWithXAxisValue : (CGFloat) xValue  andAngle : (CGFloat) valueOfAngle {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -1000;
    //this would rotate object on an axis of x = 0, y = 1, z = -0.3f. It is "Z" here which would
    transform = CATransform3DRotate(transform, valueOfAngle * M_PI / 180.0f, xValue, 0.0, 0.);
    return transform;
}
@end
