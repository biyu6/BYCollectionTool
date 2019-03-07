//
//  BYHubView.m
//  WallMeet
//
//  Created by 胡忠诚 on 2018/12/6.
//  Copyright © 2018 huaerjie. All rights reserved.
//无结果页View

#import "BYHubView.h"

@interface BYHubView()
/**提示图*/
@property(nonatomic,weak)UIImageView *promptImgView;

@end
@implementation BYHubView
#pragma mark- init初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAddSubViews];
    }
    return self;
}
- (void)initAddSubViews{
    self.backgroundColor = BYBlackColor7;
    //提示图
    _promptImgView = [BYVS createImgView:@"" addSubView:self];
    [_promptImgView sizeToFit];
    [self addSubview:_promptImgView];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshPromptVC)];
    tapGes.numberOfTouchesRequired = 1;//手指个数
    tapGes.numberOfTapsRequired = 1;//点击次数
    [self addGestureRecognizer:tapGes];
    
    [self addSubViewFrames];
}
- (void)addSubViewFrames{
    BYkWeakSelf(ws);
    //提示图
    [_promptImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.mas_centerY);
        make.centerX.equalTo(ws.mas_centerX);
    }];
    
}

#pragma mark- 数据处理
- (void)setPromptImgStr:(NSString *)promptImgStr{
    _promptImgStr = promptImgStr;
    _promptImgView.image = [UIImage imageNamed:_promptImgStr];
}

#pragma mark- 用户交互
- (void)refreshPromptVC{
    if (self.promptUploadVCRequest) {
        self.promptUploadVCRequest();
    }
}
- (void)hiddenHubView{
    if (self) {
        [self removeFromSuperview];
    }
}



@end
