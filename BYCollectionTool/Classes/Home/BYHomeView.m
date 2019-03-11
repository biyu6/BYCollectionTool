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
/**第三个按钮*/
@property(nonatomic,weak)UIImageView *threeImgView;
@property(nonatomic,weak)UILabel *threeLab;
/**第四个按钮*/
@property(nonatomic,weak)UIImageView *fourImgView;
@property(nonatomic,weak)UILabel *fourLab;

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
    
    //第三个按钮
    _threeImgView = [BYVS createImgView:@"home_rectangle" addSubView:self];
    _threeImgView.userInteractionEnabled = YES;
    _threeLab = [BYVS createLabText:@"高度不同的图片Swift" font:BYPTBoldFont15 labColor:BYWhiteColor1 addSubView:_threeImgView];
    [_threeImgView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(threeBtnClick)]];
    
    //第四个按钮
    _fourImgView = [BYVS createImgView:@"home_rectangle" addSubView:self];
    _fourImgView.userInteractionEnabled = YES;
    _fourLab = [BYVS createLabText:@"高度不同的图片OC" font:BYPTBoldFont15 labColor:BYWhiteColor1 addSubView:_fourImgView];
    [_fourImgView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fourBtnClick)]];
    
    
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
        make.top.equalTo(ws.mas_top).offset(BYHeight(64));
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
    //第三个按钮
    [_threeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(ws.oneImgView);
        make.top.equalTo(ws.twoImgView.mas_bottom).offset(BYHeight(9));
    }];
    [_threeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.threeImgView.mas_centerX);
        make.centerY.equalTo(ws.threeImgView.mas_centerY).offset(BYWidth(-3));
    }];
    //第四个按钮
    [_fourImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(ws.oneImgView);
        make.top.equalTo(ws.threeImgView.mas_bottom).offset(BYHeight(9));
    }];
    [_fourLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.fourImgView.mas_centerX);
        make.centerY.equalTo(ws.fourImgView.mas_centerY).offset(BYWidth(-3));
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
- (void)threeBtnClick{
    if (self.clickThreeBtn) {
        self.clickThreeBtn();
    }
}
- (void)fourBtnClick{
    if (self.clickFourBtn) {
        self.clickFourBtn();
    }
}
@end
