//
//  HMCycleLayout.m
//  无限轮播
//
//  Created by HM on 16/7/20.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HMCycleLayout.h"

@implementation HMCycleLayout
- (void)prepareLayout{
    [super prepareLayout];
    
    self.itemSize = self.collectionView.bounds.size;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.minimumLineSpacing = 0;
}
@end
