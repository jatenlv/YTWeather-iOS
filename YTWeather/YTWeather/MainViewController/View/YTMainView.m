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

#define kForecastCellHeight      100
#define kAdvertisingCellHeight   100
#define kDetailCellHeight        100
#define kMapCellHeight           100
#define kPrecipitationCellHeight 100
#define kSunAndWindCellHeight    100

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
        [self setupNavigationBar];

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

- (void)setupNavigationBar
{
    [self layoutIfNeeded];
    self.custonNavigationBar = [[YTMainCustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 64)];
    [self.tableView addSubview:self.custonNavigationBar];
    @weakify(self)
    self.custonNavigationBar.clickLeftBarButton = ^{
        @strongify(self)
        [self.delegate clickLeftBarButton];
    };
    self.custonNavigationBar.clickRightBarButton = ^{
        @strongify(self)
        [self.delegate clickRightBarButton];
    };
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
    switch (indexPath.row) {
        case 0: {
            YTMainForecastTableViewCell *Forecast = [tableView dequeueReusableCellWithIdentifier:[YTMainForecastTableViewCell className]];
            return Forecast;
            
        }break;
            
        default:
            break;
    }
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
    if(indexPath.row == 0)  return 295;
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
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint curRightP =  [self convertPoint:point toView:self.custonNavigationBar.rightButton];
    CGPoint curLeftP =  [self convertPoint:point toView:self.custonNavigationBar.leftBtn];

    if ([self.custonNavigationBar.rightButton pointInside:curRightP withEvent:event]) {
        return self.custonNavigationBar.rightButton;
    }else if ([self.custonNavigationBar.leftBtn pointInside:curLeftP withEvent:event]) {
        return self.custonNavigationBar.leftBtn;
    }
    else{
        return  [super hitTest:point withEvent:event];
    }
}

@end
