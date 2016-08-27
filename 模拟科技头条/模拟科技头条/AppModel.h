//
//  AppModel.h
//  模拟科技头条
//
//  Created by mac on 16/8/26.
//  Copyright © 2016年 mac. All rights reserved.
//
/*
 summary = 刚刚过去的里约奥运会，不仅对于中国体育是一个分水岭，对于中国传媒行业也是一个分水岭。对于中国公众而...;
	img = http://news.coolban.com/Upload/thumb/160826/80-60-192I61J8-0.jpg;
	addtime = 1472212186;
	id = 475252;
	type_id = 4;
	title = 短视频播放量井喷，微博让传统媒体再生“洪荒之力”;
	sitename = 百家自媒体;
	use_thumb = 0;
	src_img = http://b.hiphotos.baidu.com/news/w%3D638/sign=4e4973979516fdfad86cc5ed8c8e8cea/810a19d8bc3eb135da5c3f07ae1ea8d3fc1f44f7.jpg;
 */

#import <Foundation/Foundation.h>

@interface AppModel : NSObject
@property(copy,nonatomic)NSString * summary;
@property(copy,nonatomic)NSString * img;
@property(copy,nonatomic)NSString * addtime;
@property(copy,nonatomic)NSString * id;
@property(copy,nonatomic)NSString * title;
@property(copy,nonatomic)NSString * sitename;
@property(copy,nonatomic)NSString * use_thumb;
@property(copy,nonatomic)NSString * src_img;
+(instancetype)appModelWithDict:(NSDictionary*)dict;
@end
