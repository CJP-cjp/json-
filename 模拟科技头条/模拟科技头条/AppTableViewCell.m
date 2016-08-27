//
//  AppTableViewCell.m
//  模拟科技头条
//
//  Created by mac on 16/8/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppTableViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
@interface AppTableViewCell()
@property(weak,nonatomic)UILabel *topLabel;
@property(weak,nonatomic)UILabel *leftLabel;
@property(weak,nonatomic)UIImageView *imageV;
@property(weak,nonatomic)UILabel *rightLabel;
@end
@implementation AppTableViewCell

- (void)awakeFromNib {
    
    [self setupUI];

}
// 设置UI
-(void)setupUI
{
    //设置标题
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.numberOfLines = 0;
    topLabel.font = [UIFont systemFontOfSize:15 ];
    topLabel.text = @"fewrty基地及管理费就是垃圾费 否方法否否否 过分了点击诶";
    [topLabel sizeToFit];
    [self.contentView addSubview:topLabel];
    self.topLabel = topLabel;
    //设置来源
    UILabel *leftLabel = [[UILabel alloc]init];
    leftLabel.text = @"新浪科技";
    [leftLabel sizeToFit];
    leftLabel.font = [UIFont systemFontOfSize:10];
    leftLabel.textAlignment = NSTextAlignmentJustified;
    [self.contentView addSubview:leftLabel];
    self.leftLabel = leftLabel;
    
    //设置图片
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.contentView addSubview:imageView];
    self.imageV = imageView;
    
    
    UILabel *rightLabel = [[UILabel alloc]init];
    rightLabel.font = [UIFont systemFontOfSize:12];
        rightLabel.text =@"1472214486";
    [rightLabel sizeToFit];
    [self.contentView addSubview:rightLabel];
    self.rightLabel = rightLabel;
    
    //设置约束
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10);
       make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(imageView.mas_left).offset(-50);
        make.top.equalTo(imageView);
        make.left.equalTo(self.contentView).offset(10);
    }];
    
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topLabel);
        make.top.equalTo(topLabel.mas_bottom).offset(20);
       
    }];

    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.right.equalTo(imageView);
         make.baseline.equalTo(leftLabel);
     
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(leftLabel.mas_bottom).offset(5);
        make.size.equalTo(self);
    }];

}
#pragma mark - 重写set方法，并填充属性
-(void)setModel:(AppModel *)model
{
    _model = model;
    
    self.topLabel.text = model.title;
    self.leftLabel.text = model.sitename;
    self.rightLabel.text = model.addtime;
    
    //判断获取的图片URL是否为空，URL存在，使用UIImageView + WebCache 下载
    if (![model.src_img  isEqual: @""]){
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.src_img]];

    }else
    {
        //为空时，需要更新约束
        self.imageV.image = nil;
        
        [self.imageV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeZero);
            
        }];
        
        [self.topLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.imageV.mas_left);
            
        }];
        
        [self.rightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
        }];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
