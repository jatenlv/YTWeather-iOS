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
    [self.tableView registerNib:[YTLeftSlideTableViewNormalCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTLeftSlideTableViewNormalCell className]];
}

#pragma mark dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2 + self.cityNameArray.count;
    } else if (section == 1) {
        return 3;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTLeftSlideTableViewNormalCell * cell = [tableView dequeueReusableCellWithIdentifier:[YTLeftSlideTableViewNormalCell className]];
    
    CGFloat section = indexPath.section;
    CGFloat row = indexPath.row;
    
    if (section == 0) {
        if (row == 0) {
            cell.titleText = @"分享";
        } else if (row == 1) {
            cell.titleText = @"编辑地点";
        } else {
            cell.titleText = [self.cityNameArray objectAtIndex:row - 2];
        }
    } else if (section == 1) {
        if (row == 0) {
            cell.titleText = @"设置";
        } else if (row == 1) {
            cell.titleText = @"意见和建议";
        } else {
            cell.titleText = @"给此应用程序打分";
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 40;
    }
    return 0;
}

- (void)setCityNameArray:(NSArray *)cityNameArray
{
    _cityNameArray = cityNameArray;
    [self.tableView reloadData];
}

@end

