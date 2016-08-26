




//
//  MineModel.m
//  百度外卖轮播解析
//
//  Created by mac on 16/8/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MineModel.h"

@implementation MineModel

+(instancetype)mineModelWithDict:(NSDictionary*)dict
{
    MineModel *model = [[MineModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}
//重写这个方法，防止因为属性缺少时，崩溃
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
