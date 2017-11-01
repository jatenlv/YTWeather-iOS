//
//  YTLeftSlideView.m
//  YTWeather
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTLeftSlideView.h"

#import "YTLeftSlideTableViewNormalCell.h"

#import "YTMainRequestNetworkTool.h"

@interface YTLeftSlideView()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray * dataList;

@end

@implementation YTLeftSlideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view =  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        view.frame = self.bounds;
        [self addSubview:view];
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.dataList = [YTMainRequestNetworkTool requestDateForLeftSlideView];
    
    [self.tableView registerNib:[YTLeftSlideTableViewNormalCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTLeftSlideTableViewNormalCell className]];
}

#pragma mark dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTLeftSlideTableViewNormalCell * cell = [tableView dequeueReusableCellWithIdentifier:[YTLeftSlideTableViewNormalCell className]];
    cell.titleText = self.dataList[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *title = @[@"登录/注册", @"工具", @"ICON"];
    return title[section];
}

- (void)setCityNameArray:(NSArray *)cityNameArray
{
    [self.tableView reloadData];
}

@end

