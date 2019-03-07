//
//  BYHomeView.m
//  OnlineEdu
//
//  Created by biyu6 on 2019/3/5.
//  Copyright © 2019 cameroon. All rights reserved.
//首页View

#import "BYHomeView.h"

@interface BYHomeView()
/**第一个按钮*/
@property(nonatomic,weak)UIImageView *oneImgView;
@property(nonatomic,weak)UILabel *oneLab;
/**第二个按钮*/
@property(nonatomic,weak)UIImageView *twoImgView;
@property(nonatomic,weak)UILabel *twoLab;
/**logo*/
@property(nonatomic,weak)UIImageView *logoImgView;

@end
@implementation BYHomeView
#pragma mark- init初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initAddSubViews];
    }
    return self;
}
- (void)initAddSubViews{
    //背景
    self.userInteractionEnabled = YES;
    self.image = [UIImage imageNamed:@"home_bg"];
    
    //第一个按钮
    _oneImgView = [BYVS createImgView:@"home_rectangle" addSubView:self];
    _oneImgView.userInteractionEnabled = YES;
    _oneLab = [BYVS createLabText:@"基础的瀑布流" font:BYPTBoldFont15 labColor:BYWhiteColor1 addSubView:_oneImgView];
    [_oneImgView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneBtnClick)]];
    
    //第二个按钮
    _twoImgView = [BYVS createImgView:@"home_rectangle" addSubView:self];
    _twoImgView.userInteractionEnabled = YES;
    _twoLab = [BYVS createLabText:@"CoverFlow效果" font:BYPTBoldFont15 labColor:BYWhiteColor1 addSubView:_twoImgView];
    [_twoImgView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoBtnClick)]];
    
    //logo
    _logoImgView = [BYVS createImgView:@"home_logo" addSubView:self];
    
    
    [self addSubViewFrames];
}
- (void)addSubViewFrames{
    BYkWeakSelf(ws);
    //第一个按钮
    [_oneImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(BYWidth(217));
        make.height.offset(BYWidth(57));
        make.top.equalTo(ws.mas_top).offset(BYHeight(103));
        make.centerX.equalTo(ws.mas_centerX);
    }];
    [_oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.oneImgView.mas_centerX);
        make.centerY.equalTo(ws.oneImgView.mas_centerY).offset(BYWidth(-3));
    }];
    //第二个按钮
    [_twoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(ws.oneImgView);
        make.top.equalTo(ws.oneImgView.mas_bottom).offset(BYHeight(9));
    }];
    [_twoLab mas_makeConstraints:^(MASConstraintMaker *make) {//logo
        make.centerX.equalTo(ws.twoImgView.mas_centerX);
        make.centerY.equalTo(ws.twoImgView.mas_centerY).offset(BYWidth(-3));
    }];
    //logo
    [_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.mas_centerX);
        make.bottom.equalTo(ws.mas_bottom).offset(BYHeight(-20));
        make.width.offset(BYWidth(80));
        make.height.offset(BYWidth(24));
    }];
}
#pragma mark- 用户交互
- (void)oneBtnClick{
    if (self.clickOneBtn) {
        self.clickOneBtn();
    }
}
- (void)twoBtnClick{
    if (self.clickTwoBtn) {
        self.clickTwoBtn();
    }
}


@end
