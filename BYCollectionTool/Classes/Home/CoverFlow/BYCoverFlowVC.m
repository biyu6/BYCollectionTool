//
//  BYCoverFlowVC.m
//  OnlineEdu
//
//  Created by biyu6 on 2019/3/6.
//  Copyright © 2019 cameroon. All rights reserved.
//CoverFlow的VC

#import "BYCoverFlowVC.h"
#import "BYCoverFlowLayout.h"//CoverFlow自定义layout
#import "BYCoverFlowCell.h"//CoverFlow自定义Cell

#define CellCount 40
static NSString *cellIdStr = @"coverFlow_Cell";
@interface BYCoverFlowVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;

@end
@implementation BYCoverFlowVC
#pragma mark- init初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self scrollViewDidScroll:self.collectionView];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)setupUI{
    self.view.backgroundColor = BYWhiteColor1;
    BYCoverFlowLayout *flowLayout = [[BYCoverFlowLayout alloc]init];//创建一个流式布局
    //创建UICollectionView
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, BYScreenWidth, 150) collectionViewLayout:flowLayout];
    [_collectionView registerClass:[BYCoverFlowCell class] forCellWithReuseIdentifier:cellIdStr];
    flowLayout.itemSize = CGSizeMake(110, 110);//设置item大小
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//水平滚动
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
}

#pragma mark- 瀑布流方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return CellCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BYCoverFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdStr forIndexPath:indexPath];
    [cell setIndexPath:indexPath itemCount:CellCount];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了item");
}

#pragma mark- 滚动的代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 坐标系转换获得collectionView上面的位于中心的cell
    CGPoint pointInView = [self.view convertPoint:self.collectionView.center toView:self.collectionView];
    // 获取这一点的indexPath
    NSIndexPath *indexPathNow = [self.collectionView indexPathForItemAtPoint:pointInView];
    BYCoverFlowCell *cell = (BYCoverFlowCell *)[self.collectionView cellForItemAtIndexPath:indexPathNow];
    [self.collectionView bringSubviewToFront:cell];
}
- (void)dealloc{
    NSLog(@"已释放");
}


@end
