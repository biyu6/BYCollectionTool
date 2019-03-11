//
//  BYIconFlowCollectionCell.m
//  BYCollectionTool
//
//  Created by biyu6 on 2019/3/11.
//  Copyright © 2019 biyu6. All rights reserved.
//

#import "BYIconFlowCollectionCell.h"

@implementation BYIconFlowCollectionCell
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
    _imgView = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-25)];
    self.backgroundView = _imgView;
}


@end
