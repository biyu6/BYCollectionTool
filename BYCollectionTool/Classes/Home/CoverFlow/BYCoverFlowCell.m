//
//  BYCoverFlowCell.m
//  OnlineEdu
//
//  Created by biyu6 on 2019/3/6.
//  Copyright © 2019 cameroon. All rights reserved.
//CoverFlow自定义Cell

#import "BYCoverFlowCell.h"

@interface BYCoverFlowCell()
/**标识*/
@property(nonatomic,weak)UILabel *bsLab;

@end
@implementation BYCoverFlowCell
#pragma mark- init初始化
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initAddSubViews];
    }
    return self;
}
- (void)initAddSubViews{
    //标识
    _bsLab = [BYVS createLabText:@"" font:BYPTFont15 labColor:BYRedColor1 addSubView:self];
    [_bsLab sizeToFit];

    [self addSubViewFrames];
}
- (void)addSubViewFrames{
    BYkWeakSelf(ws);
    [_bsLab mas_makeConstraints:^(MASConstraintMaker *make) {//标识
        make.centerX.equalTo(ws.mas_centerX);
        make.centerY.equalTo(ws.mas_centerY);
    }];
}
- (void)setIndexPath:(NSIndexPath *)indexPath itemCount:(int)count{
    self.backgroundColor = BYRandomColor;
    _bsLab.text = [NSString stringWithFormat:@"%@ / %@", @(indexPath.item), @(count)];
}


@end
