//
//  BYIconFlowVC.m
//  BYCollectionTool
//
//  Created by biyu6 on 2019/3/11.
//  Copyright © 2019 biyu6. All rights reserved.
//不同高度图片布局的VC——OC

#import "BYIconFlowVC.h"
#import "BYIconFlowLayout.h"//图片的布局样式
#import "BYIconFlowCollectionCell.h"//瀑布流cell
#import "YBImageBrowser.h"
//#import "MainImageCell.h"

static NSString *cellIdStr = @"IconFlow_Cell";
@interface BYIconFlowVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
/**瀑布流布局*/
@property(nonatomic,strong)BYIconFlowLayout *iconFlowLayout;
/**数据源数组*/
@property(nonatomic,strong)NSMutableArray *iconNameArrM;

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
    [_collectionView registerClass:[BYIconFlowCollectionCell class] forCellWithReuseIdentifier:cellIdStr];
//    [_collectionView registerClass:[MainImageCell class] forCellWithReuseIdentifier:cellIdStr];
    _collectionView.backgroundColor = [UIColor whiteColor];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//水平滚动
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
}

- (void)getData{
    _iconNameArrM = [NSMutableArray array];
    NSMutableArray *imgArrM =  [NSMutableArray array];
    for (int i=0; i<11; i++) {
        NSString *str = [NSString stringWithFormat:@"gif_%d.gif",i];
//    for (int i=0; i<18; i++) {
//        NSString *str = [NSString stringWithFormat:@"img_%d.jpg",i];
        [_iconNameArrM addObject:str];
        YYImage *img = [YYImage imageNamed:str];
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
    return _iconNameArrM.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BYIconFlowCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdStr forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:_iconNameArrM[indexPath.row]];
//    MainImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdStr forIndexPath:indexPath];
//    cell.data = self.iconNameArrM[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了item");
     [self showBrowserForMixedCaseWithIndex:indexPath.row];
}
- (void)dealloc{
    NSLog(@"已释放");
}


#pragma mark- 图片浏览器
- (void)showBrowserForMixedCaseWithIndex:(NSInteger)index {
    NSMutableArray *browserDataArr = [NSMutableArray array];
    [self.iconNameArrM enumerateObjectsUsingBlock:^(NSString *_Nonnull imageStr, NSUInteger idx, BOOL * _Nonnull stop) {
        // 此处只是为了判断测试用例的数据源是否为视频，并不是仅支持 MP4。/ This is just to determine whether the data source of the test case is video, not just MP4.
        if ([imageStr hasSuffix:@".MP4"]) {
            if ([imageStr hasPrefix:@"http"]) {// Type 1 : 网络视频 / Network video
                YBVideoBrowseCellData *data = [YBVideoBrowseCellData new];
                data.url = [NSURL URLWithString:imageStr];
                data.sourceObject = [self sourceObjAtIdx:idx];
                [browserDataArr addObject:data];
            } else {// Type 2 : 本地视频 / Local video
                NSString *path = [[NSBundle mainBundle] pathForResource:imageStr.stringByDeletingPathExtension ofType:imageStr.pathExtension];
                NSURL *url = [NSURL fileURLWithPath:path];
                YBVideoBrowseCellData *data = [YBVideoBrowseCellData new];
                data.url = url;
                data.sourceObject = [self sourceObjAtIdx:idx];
                [browserDataArr addObject:data];
            }
        } else if ([imageStr hasPrefix:@"http"]) {// Type 3 : 网络图片 / Network image
            YBImageBrowseCellData *data = [YBImageBrowseCellData new];
            data.url = [NSURL URLWithString:imageStr];
            data.sourceObject = [self sourceObjAtIdx:idx];
            [browserDataArr addObject:data];
        } else {// Type 4 : 本地图片 / Local image (配置本地图片推荐使用 YBImage)
            YBImageBrowseCellData *data = [YBImageBrowseCellData new];
            data.imageBlock = ^__kindof UIImage * _Nullable{
                return [YBImage imageNamed:imageStr];
            };
            data.sourceObject = [self sourceObjAtIdx:idx];
            [browserDataArr addObject:data];
        }
    }];
    //Type 5 : 自定义 / Custom
//    CustomCellData *data = [CustomCellData new];
//    data.text = @"Custom Cell";
//    [browserDataArr addObject:data];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = browserDataArr;
    browser.currentIndex = index;
    [browser show];
}
#pragma mark - Tool
- (id)sourceObjAtIdx:(NSInteger)idx {
//    MainImageCell *cell = (MainImageCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
//    return cell ? cell.mainImageView : nil;
    BYIconFlowCollectionCell *cell = (BYIconFlowCollectionCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
    return cell ? cell.imgView : nil;
    
}

@end
