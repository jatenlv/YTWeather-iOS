//
//  YTMainView.m
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainView.h"

#import "YTMainTableHeaderView.h"
#import "YTMainForecastTableViewCell.h"
#import "YTMainAdvertisingTableViewCell.h"
#import "YTMainDetailTableViewCell.h"
#import "YTMainMapTableViewCell.h"
#import "YTMainPrecipitationTableViewCell.h"
#import "YTMainSunAndWindTableViewCell.h"

#import "YTMainCustomNavigationBar.h"

@interface YTMainView ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, strong)  YTMainCustomNavigationBar *custonNavigationBar;

@end

@implementation YTMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view =  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        view.frame = self.bounds;
        view.width = ScreenWidth;
        [self addSubview:view];
        
        [self setupTableView];
        [self.tableView.mj_header beginRefreshing];
    }
    return self;
}

- (void)setupTableView
{
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.tableView.bounds];
    [backImageView setImage:[UIImage imageNamed:@"foggy_n_portrait.jpg"]];
    self.tableView.backgroundView = backImageView;
    
    self.custonNavigationBar = [[YTMainCustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    [self.tableView addSubview:self.custonNavigationBar];
    self.custonNavigationBar.clickLeftBarButton = ^{
        [self.delegate clickLeftBarButton];
    };
    self.custonNavigationBar.clickRightBarButton = ^{
        [self.delegate clickRightBarButton];
    };
    
    [self.tableView registerNib:[YTMainForecastTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainForecastTableViewCell className]];
    
    [self.tableView registerNib:[YTMainAdvertisingTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainAdvertisingTableViewCell className]];

    [self.tableView registerNib:[YTMainForecastTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainForecastTableViewCell className]];

    [self.tableView registerNib:[YTMainDetailTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainDetailTableViewCell className]];

    [self.tableView registerNib:[YTMainMapTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainMapTableViewCell className]];

    [self.tableView registerNib:[YTMainPrecipitationTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainPrecipitationTableViewCell className]];

    [self.tableView registerNib:[YTMainSunAndWindTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainSunAndWindTableViewCell className]];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.delegate loadData];
    }];
}

#pragma mark - Data

- (void)setWeatherModel:(YTWeatherModel *)weatherModel
{
    _weatherModel = weatherModel;
    [self.tableView reloadData];
}

#pragma mark - Tableview Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

#pragma mark - Tableview Delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YTMainTableHeaderView *headerView = [[YTMainTableHeaderView alloc] init];
    headerView.nowModel = self.weatherModel.now;
    headerView.dailyForecastModel = [self.weatherModel.daily_forecast objectAtIndex:0];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScreenHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    if (offset > 0) {
        self.custonNavigationBar.mj_y = offset;
    }
}


@end
