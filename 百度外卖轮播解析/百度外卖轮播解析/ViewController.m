//
//  ViewController.m
//  百度外卖轮播解析
//
//  Created by mac on 16/8/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "MineModel.h"
#import "HMCycleView.h"
#import "Masonry.h"
@interface ViewController ()
{
    // 创建图片数组
    NSArray*_imageList;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self loadData];
//  [self setupUI];
}

#pragma mark - 下载图片

-(void)loadData
{
    //获取URL
    NSURL *url = [NSURL URLWithString:@"http://163.177.151.20/shopui/na/v1/cliententry?da_ext=&msgcuid=&return_type=refresh&net_type=wifi&aoi_id=2439504856968321549&taste=&address=%E5%8D%97%E5%BA%97%E6%96%B0%E6%9D%91&screen=320x568&cheatfrom=wmapp&cheatios=iMwjtcIQ3fweNtKCABEFQboWAy5pQgNtXAdkTirIPd1RgaF70pIlnMwdo2%2FTz8KbyyEXwOIIaXi%2BFH6GzmGEzx0Wh%2Bo%2Bf7l%2BrEAycfn%2FCeAb0DFf3zsYq%2B6WAOC2OGIsEWAB5t2AJ0%2Fnk8ys0mE4miCLTLG77YXPcPUAbvdUH0xidcFthBHq5lUbTQBQeef4MsS6eePZy%2Fzmpi5APuIbZtCuqb3qSSRGb5dnS3KHT6qm%2F%2BX62412wKU5b%2FLDEHFFhImKMIFqwXcfW2GNSFAhiL5VvY%2BuUMnMKom5olJKxgA4corAov5EOc6NlfvhN0aStvcFgJF8401KZfD4fMpggOWXyHGVepQBT2EKKgyxp9WMPG%2BzeqnbsiO0omWckMK5wWmQPmeRSfotpsYXch2eRyVv42uHAleBh4%2BvlWt%2B%2FQ%2FmTZKgVCuTh7Z0ZXBseci%2FBtdJLC5%2BQJTFWRc%2F%2FcpjvGWyOhQnR8pwrYv42mkPmhMWpH70WQoWE5Y27GqTu9RjQFuq8i8adUfEhtAVBIZWkDse91ZetyLFtz6r8JxIKJRtzFQb9%2FmJGpWAkXmJuiL%2FiTT7p0ZBtdeeRDegqCqN%2BWTinmIRWAFg0f8OpI3ItimKoMRzaQk7szRQDG6Ks%2FVwyVV6P2M%2FDBHV9BbPjsgPO9XL4dGYrQKxGOGV1neGf1%2FMZkR%2Fz9fcU%2FTrM4U538Gluz8fwPRTc2jUUBXYMJJZmg%3D%3D&sortby=&cuid=3D0A8678-18DC-4447-9611-13A411B1FCF9&hot_fix=1&uuid=C99F87B1-9588-443D-8BBA-D5DAE3CB57E1&alipay=1&sv=4.0.0&isp=46001&channel=appstore&loc_lng=12951328.778846&resid=1001&from=na-iphone&request_time=1472034210515&model=iPhone6%2C2&count=20&lng=12951333.031847&idfa=8EFD4589-EDD2-4958-A717-9AF218CBC152&page=1&os=9.3.1&lat=4847613.653197&loc_lat=4847611.463607&promotion=&city_id=131&vmgdb=&jailbreak=0&device_name=%E2%80%9C%E5%BC%A0%E6%9D%B0%E2%80%9D%E7%9A%84%20iPhone"];
    
     //测试
    NSLog(@"11111111%@",[NSThread currentThread]);

    //session,发起任务，任务启动  ----经测试，任务启动等是在子线程中进行的。
    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil && data !=nil) {
            
            //测试
            NSLog(@"22222%@",[NSThread currentThread]);

            NSArray *imageurl =[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL][@"result"][@"activity_mobile"];
            
            NSMutableArray *imageArray = [NSMutableArray array];
            
            //遍历字典转模型
            [imageurl enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                MineModel *model = [MineModel mineModelWithDict:obj];
                
                 //测试
                 NSLog(@"下载图片%@",[NSThread currentThread]);
                
                //下载图片
                NSURL *url = [NSURL URLWithString:model.img];
                NSData *data = [NSData dataWithContentsOfURL:url];
                UIImage *image = [UIImage imageWithData:data];
                
                //测试
                NSLog(@"%@",[NSThread currentThread]);
                
                
                [imageArray addObject:image];
                
            }];
          
            _imageList = imageArray.copy;
            
            //回到主线程更新UI
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                
                //测试
                NSLog(@"更新UI%@",[NSThread currentThread]);
                
                //更新UI
                [self setupUI];
                
                
            }];
            
        }else
        {
            NSLog(@"%@",error);
        }
    }]resume];
}

#pragma mark - 设置UI

-(void)setupUI
{
    HMCycleView *cV = [[HMCycleView alloc]init];
    
    [self.view addSubview: cV];
    
    //设置约束
    [cV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(300);
    }];
    
    //传值
    cV.imageList = _imageList;
   


    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
