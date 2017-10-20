//
//  YTLeftSlideView.m
//  YTWeather
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTLeftSlideView.h"
#import "YTMainRequestNetworkTool.h"
@interface YTLeftSlideView()
<
//UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) NSArray * dataList;
@end

@implementation YTLeftSlideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        [self setup];
    }
    
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];

}
- (void)setup
{
    _dataList = [YTMainRequestNetworkTool requestDateForLeftSlideView];
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.dataSource = self;
}
#pragma mark dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  _dataList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataList[section] count];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = _dataList[indexPath.section][indexPath.row];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *title = @[@"地点",@"工具"];
    return  title[section];
}
@end
