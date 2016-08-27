//
//  AppModel.m
//  模拟科技头条
//
//  Created by mac on 16/8/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel
+(instancetype)appModelWithDict:(NSDictionary*)dict
{
    AppModel *model = [[AppModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
//-(NSString *)description
//{
//    return [NSString stringWithFormat:@"%@-%@",self.title,self.sitename];
//}
@end
