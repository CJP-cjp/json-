//
//  ViewController.m
//  模拟科技头条
//
//  Created by mac on 16/8/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "AppModel.h"
#import "AppTableViewCell.h"
@interface ViewController ()<UITableViewDataSource>
{
    //用于记录模型的
    NSArray *_groupList;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置cell自动计算行高
    self.tableView.estimatedRowHeight = 70;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //加载数据
    [self loadJsonData];
    
}
//加载数据
-(void)loadJsonData
{
    //URL
    NSURL *url = [NSURL URLWithString:@"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/1472031475/type/0?channel=appstore&uuid=1CF3D8F1-1DFA-4F0B-8335-40F209B0E355&net=5&model=iPhone&ver=1.0.5"];
    //session任务发起，任务启动
    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil && data != nil) {
            id resqult = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *arrayM = [NSMutableArray array];
            
            //遍历数组转模型
            [resqult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                AppModel *model = [AppModel appModelWithDict:obj];
                [arrayM addObject:model];
            }];
            
            //赋值
            _groupList = arrayM.copy;
            
            // 在主线程刷新数据
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                
               [self.tableView reloadData];
                
            }];
        }else
        {
            NSLog(@"%@",error);
        }
    }]resume];
}

#pragma mark - 实现数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _groupList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    AppModel *model = _groupList[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
