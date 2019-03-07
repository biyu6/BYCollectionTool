//
//  BYHomeVC.m
//  OnlineEdu
//
//  Created by 胡忠诚 on 2019/3/1.
//  Copyright © 2019 cameroon. All rights reserved.
//首页VC

#import "BYHomeVC.h"
#import "BYHomeView.h"//首页View
#import "BYEasyVC.h"//最简单的collectionView实现
#import "BYCoverFlowVC.h"//CoverFlow的VC

@interface BYHomeVC ()
/**首页View*/
@property(nonatomic,strong)BYHomeView *homeView;

@end
@implementation BYHomeVC
#pragma mark- init初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
    [self addSubViewClick];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)initSubViews{
    _homeView = [[BYHomeView alloc]init];
    _homeView.frame = CGRectMake(0, 0, BYScreenWidth, BYScreenHeight);
    [self.view addSubview:_homeView];
}

#pragma mark- 用户交互
- (void)addSubViewClick{
    BYkWeakSelf(ws);
    _homeView.clickOneBtn = ^{
        [ws jumpEasyVC];
    };
    _homeView.clickTwoBtn = ^{
         [ws jumpCoverFlowVC];
    };
}
- (void)jumpEasyVC{//最简单的collectionView实现
    BYEasyVC*easyVC = [[BYEasyVC alloc]init];
    [self.navigationController pushViewController:easyVC animated:YES];
}
- (void)jumpCoverFlowVC{//CoverFlowVC效果
    BYCoverFlowVC *cfVC = [[BYCoverFlowVC alloc]init];
    [self.navigationController pushViewController:cfVC animated:YES];
}

#pragma mark- 其他
- (void)dealloc{
    NSLog(@"已释放");
}


@end