//
//  YTLeftSlideView.m
//  YTWeather
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTLeftSlideView.h"

#import "YTLeftSlideTableViewNormalCell.h"
#import "YTLeftSlideTableViewToolCell.h"
#import "YTLeftSlideTableViewNoticeCell.h"

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
    [self.tableView registerNib:[YTLeftSlideTableViewToolCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTLeftSlideTableViewToolCell className]];
    [self.tableView registerNib:[YTLeftSlideTableViewNoticeCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTLeftSlideTableViewNoticeCell className]];
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
        return 4;
    } else {
        return 1;
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
            YTLeftSlideTableViewToolCell * cell = [tableView dequeueReusableCellWithIdentifier:[YTLeftSlideTableViewToolCell className]];
            return cell;
        } else if (row == 1) {
            cell.titleText = @"设置";
        } else if (row == 2) {
            cell.titleText = @"意见和建议";
        } else {
            cell.titleText = @"给此应用程序打分";
        }
    } else {
        YTLeftSlideTableViewNoticeCell * cell = [tableView dequeueReusableCellWithIdentifier:[YTLeftSlideTableViewNoticeCell className]];
        return cell;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        return 45.0f;
    } else if (indexPath.section == 2) {
        return 120.0f;
    }
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row >= 2) {
        [self.delegate showCityViewWithIndex:indexPath.row - 2];
    }
}

- (void)setCityNameArray:(NSArray *)cityNameArray
{
    _cityNameArray = cityNameArray;
    [self.tableView reloadData];
}

@end

