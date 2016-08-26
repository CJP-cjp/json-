//
//  HMCycleCell.m
//  无限轮播
//
//  Created by HM on 16/7/20.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HMCycleCell.h"
#import "Masonry.h"
@interface HMCycleCell()
@property (weak, nonatomic) UIImageView *imageView;
@end
@implementation HMCycleCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}
- (void)setPicture:(UIImage *)picture{
    _picture = picture;
    
    self.imageView.image = picture;
    
}
@end
