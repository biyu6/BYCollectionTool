//
//  BYIconFlowVC.m
//  BYCollectionTool
//
//  Created by biyu6 on 2019/3/11.
//  Copyright © 2019 biyu6. All rights reserved.
//不同高度图片布局的VC——OC

#import "BYIconFlowVC.h"
#import "BYIconFlowLayout.h"//图片的布局样式


static NSString *cellIdStr = @"IconFlow_Cell";
@interface BYIconFlowVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
/**瀑布流布局*/
@property(nonatomic,strong)BYIconFlowLayout *iconFlowLayout;
/**数据源数组*/
@property(nonatomic,strong)NSMutableArray *iconArrM;


@end
@implementation BYIconFlowVC
#pragma mark- init初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getData];
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
    BYIconFlowLayout *flowLayout = [[BYIconFlowLayout alloc]init];//创建一个流式布局
    _iconFlowLayout = flowLayout;
    //创建UICollectionView
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdStr];
    _collectionView.backgroundColor = [UIColor whiteColor];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//水平滚动
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
}

- (void)getData{
    _iconArrM = [NSMutableArray array];
    NSMutableArray *imgArrM =  [NSMutableArray array];
    for (int i=0; i<17; i++) {
        NSString *str = [NSString stringWithFormat:@"img_%d",i];
        [_iconArrM addObject:str];
        UIImage *img = [UIImage imageNamed:str];
        [imgArrM addObject:img];
    }
    _iconFlowLayout.dataArr = imgArrM;//给瀑布流布局赋值
    [_collectionView reloadData];//刷新
}
#pragma mark- 瀑布流方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _iconArrM.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdStr forIndexPath:indexPath];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height-25)];
    imgView.image = [UIImage imageNamed:_iconArrM[indexPath.row]];
    cell.backgroundView = imgView;
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了item");
}
- (void)dealloc{
    NSLog(@"已释放");
}


@end
