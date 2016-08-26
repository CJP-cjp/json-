//
//  HMCycleView.m
//  无限轮播
//
//  Created by HM on 16/7/20.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HMCycleView.h"
#import "HMCycleLayout.h"
#import "Masonry.h"
#import "HMCycleCell.h"
#define kSeed  100
static NSString *cellID = @"cellID";
@interface HMCycleView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) UIPageControl *pageControl;
@property (weak, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSTimer *timer;
@end
@implementation HMCycleView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
//    self.backgroundColor = [UIColor redColor];
    HMCycleLayout *layout = [[HMCycleLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [self addSubview:collectionView];
    
    
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[HMCycleCell class] forCellWithReuseIdentifier:cellID];
    self.collectionView = collectionView;
    
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    
    pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.8 alpha:1];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:0.2 alpha:1];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-20);
    }];
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(10);
    }];
    
    //timerInterval：以秒为单位的时间
    //target:调用方法的对象
    //selector:调用的方法
    //repeats:是否重复
    //每隔2秒钟，会调用一次self的playPicture方法
    //创建了一个定时器，并且把它以默认模式添加到运行循环里。
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(playPicture) userInfo:nil repeats:YES];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(playPicture) userInfo:nil repeats:YES];
    //以通用模式把定时器添加到运行循环里。
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
- (void)playPicture{
    //让collectionView进行滚动
    //1.获取到collectionView当前的滚动偏移量的x值
    CGFloat offsetX = self.collectionView.contentOffset.x;
    offsetX += self.collectionView.bounds.size.width;
    //2.把原来的偏移量再加一个collectionView的宽度,并且把它设置给collectionView
//    self.collectionView.contentOffset = CGPointMake(offsetX, 0);
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
#pragma mark -collectionView的数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageList.count *kSeed;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HMCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.picture = _imageList[indexPath.item % _imageList.count];
    
    return cell;
}
#pragma mark -collectionView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat page = offsetX / scrollView.bounds.size.width;
    
    self.pageControl.currentPage = (NSInteger)(page + 0.5) % _imageList.count;
}

//当scrollView停止减速的时候，会调用这个方法.
//大致理解为collectionView停止滚动的时候会调用这个方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"xxxxx");
    //1.获取到停止滚动的时候，当前显示的是第几个cell
    UICollectionViewCell *cell = [[self.collectionView visibleCells]lastObject];
    //2.根据cell，拿到这个cell的indexPath
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    //3.判断当前cell是否是最后一个
    //3.1先要获取collectionView里一共有多少个cell
    //第0组里一共有多少个item
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    //3.2判断当前cell是不是最后一个
    if (indexPath.item == itemCount - 1) {
        //4.让collectionView跳转到图片的个数 - 1个item
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForItem:_imageList.count*kSeed *0.5 -1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:toIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    
    //如果滚动到了第0个条目
    if (indexPath.item == 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_imageList.count*kSeed*0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
}
//当scrollView将要被拖拽的时候，会调用这个方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //把定时器给停掉
    self.timer.fireDate = [NSDate distantFuture];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //从现在开始隔2秒钟以后，开火
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2.0];
}
#pragma mark -获取到从控制传递过来的数据
- (void)setImageList:(NSArray *)imageList{
    _imageList = imageList;
    
    self.pageControl.numberOfPages = _imageList.count;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_imageList.count*kSeed*0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}
//当无限轮播从父控件上移除的时候，把定时器给停掉
- (void)removeFromSuperview{
    [super removeFromSuperview];
    //停掉定时器
    [self.timer invalidate];
}
@end
