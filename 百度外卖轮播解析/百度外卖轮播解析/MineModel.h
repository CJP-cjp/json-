//
//  MineModel.h
//  百度外卖轮播解析
//
//  Created by mac on 16/8/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineModel : NSObject

//图片的地址
@property(copy,nonatomic)NSString *img;

//快速创建模型对象
+(instancetype)mineModelWithDict:(NSDictionary*)dict;

@end
