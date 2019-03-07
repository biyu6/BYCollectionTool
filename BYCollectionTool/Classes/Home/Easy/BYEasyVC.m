//
//  BYEasyVC.m
//  OnlineEdu
//
//  Created by biyu6 on 2019/3/6.
//  Copyright © 2019 cameroon. All rights reserved.
//最简单的collectionView实现

#import "BYEasyVC.h"

static NSString *cellIdStr = @"test_cell";
@interface BYEasyVC ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end
@implementation BYEasyVC
#pragma mark- init初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)setupUI{
    self.view.backgroundColor = BYWhiteColor1;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];//创建一个流式布局
    //创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, BYScreenWidth, BYScreenHeight - 64) collectionViewLayout:flowLayout];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdStr];//注册cell
    flowLayout.sectionInset = UIEdgeInsetsMake(30, 0, 0, 0);//设置组间距
    flowLayout.itemSize = CGSizeMake(100, 100);//设置item大小
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
}

#pragma mark- 瀑布流方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return section + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdStr forIndexPath:indexPath];
    cell.backgroundColor = BYRedColor1;
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了item");
}
- (void)dealloc{
    NSLog(@"已释放");
}


@end
