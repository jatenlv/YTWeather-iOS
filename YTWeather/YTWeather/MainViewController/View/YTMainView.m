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
#import "YTMainPrecipitationTableViewCell.h"
#import "YTMainSunAndWindTableViewCell.h"
#import "YTMainEmptyTableViewCell.h"

#import "YTMainCustomNavigationBar.h"
#import "YTCustomRefreshGifHeader.h"

#define kCustomNavigationBarHeight (Device_Is_iPhoneX ? 84 : 54)

#define kForecastCellHeight      420
#define kAdvertisingCellHeight   250
#define kDetailCellHeight        180
#define kPrecipitationCellHeight 120
#define kSunAndWindCellHeight    250
#define kEmptyCellHeight         10

@interface YTMainView ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, strong) YTMainCustomNavigationBar *customNavigationBar;

@property (nonatomic, strong) YTWeatherNormalModel *weatherModel;
@property (nonatomic, strong) YTWeatherAirModel *airModel;

@property (nonatomic, strong) UIVisualEffectView *effectView;

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

        [self setupCustomNavigationBar];
        [self setupTableView];
        [self.tableView.mj_header beginRefreshing];
    }
    return self;
}

- (void)setupCustomNavigationBar
{
    self.customNavigationBar = [[YTMainCustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kCustomNavigationBarHeight)];
    [self addSubview:self.customNavigationBar];
    @weakify(self);
    self.customNavigationBar.clickLeftBarButton = ^{
        @strongify(self);
        [self.delegate clickLeftBarButton];
    };
    self.customNavigationBar.clickRightBarButton = ^{
        @strongify(self);
        [self.delegate clickRightBarButton];
    };
}

- (void)setupTableView
{
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    UIView *tableViewBackgroundView = [[UIView alloc] initWithFrame:ScreenBounds];
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:ScreenBounds];
    [backImageView setImage:[UIImage imageNamed:@"foggy_n_portrait.jpg"]];
    [tableViewBackgroundView addSubview:backImageView];

    self.effectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    self.effectView.frame = ScreenBounds;
    self.effectView.alpha = 0;
    [tableViewBackgroundView addSubview:self.effectView];
    
    self.tableView.backgroundView = tableViewBackgroundView;
        
    UIView *ytHeaderRefreshBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -500, ScreenWidth, 500)];
    ytHeaderRefreshBackgroundView.backgroundColor = MainTableViewCellColor;
    [self.tableView addSubview:ytHeaderRefreshBackgroundView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView registerNib:[YTMainForecastTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainForecastTableViewCell className]];
    
    [self.tableView registerNib:[YTMainAdvertisingTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainAdvertisingTableViewCell className]];

    [self.tableView registerNib:[YTMainForecastTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainForecastTableViewCell className]];

    [self.tableView registerNib:[YTMainDetailTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainDetailTableViewCell className]];

    [self.tableView registerNib:[YTMainPrecipitationTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainPrecipitationTableViewCell className]];

    [self.tableView registerNib:[YTMainSunAndWindTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainSunAndWindTableViewCell className]];
    
    [self.tableView registerNib:[YTMainEmptyTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainEmptyTableViewCell className]];

    self.tableView.mj_header = [YTCustomRefreshGifHeader headerWithCustomerGifRefreshingBlock:^{
        [self.delegate refreshData:self];
    }];
    
    [self.tableView bringSubviewToFront:self.tableView.mj_header];
}

#pragma mark - Data

- (void)setWeatherAndAirModel:(YTWeatherNormalModel *)weatherModel airModel:(YTWeatherAirModel *)airModel
{
    self.weatherModel = weatherModel;
    self.airModel = airModel;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.customNavigationBar.cityNameText = self.weatherModel.basic.location;
        [self.tableView reloadData];
    });
}

#pragma mark - Tableview Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: {
            YTMainForecastTableViewCell *ForecastCell = [tableView dequeueReusableCellWithIdentifier:[YTMainForecastTableViewCell className]];
            ForecastCell.dailyForecastModelList = self.weatherModel.daily_forecast;
            ForecastCell.hourlyForecastModelList = self.weatherModel.hourly;
            return ForecastCell;
        } break;
            
        case 2: {
            YTMainAdvertisingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YTMainAdvertisingTableViewCell className]];
            return cell;
        } break;
        
        case 4: {
            YTMainDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YTMainDetailTableViewCell className]];
            cell.nowModel = self.weatherModel.now;
            cell.airNowModel = self.airModel;
            return cell;
        } break;
           
        case 6: {
            YTMainPrecipitationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YTMainPrecipitationTableViewCell className]];
            cell.hourlyModelList = self.weatherModel.hourly;
            return cell;
        } break;
            
        case 8: {
            YTMainSunAndWindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YTMainSunAndWindTableViewCell className]];
            cell.nowModel = self.weatherModel.now;
            cell.airModel = self.airModel;
            cell.dailyModel = [self.weatherModel.daily_forecast firstObject];
            return cell;
        } break;
            
        default: {
            YTMainEmptyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YTMainEmptyTableViewCell className]];
            return cell;
        } break;
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
    if (indexPath.row == 0)     return kForecastCellHeight;
    if (indexPath.row == 2)     return kAdvertisingCellHeight;
    if (indexPath.row == 4)     return kDetailCellHeight;
    if (indexPath.row == 6)     return kPrecipitationCellHeight;
    if (indexPath.row == 8)    return kSunAndWindCellHeight;
    if (indexPath.row % 2 == 1) return kEmptyCellHeight;

    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScreenHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8.0f;
}

#pragma mark - delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    // 固定navigationBar位置
    if (offset <= 0) {
        self.customNavigationBar.mj_y = -offset;
    }
    // 更改navigationBar透明度
    if (offset >= 0 && offset <= ScreenHeight) {
        self.customNavigationBar.darkVisualEffectViewAlpha = offset / ScreenHeight;
    }
    // 更改effectView毛玻璃效果的透明度
    if (offset >=0 && offset <= ScreenHeight) {
        self.effectView.alpha = offset / ScreenHeight;
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(mainTableViewDidScrollWithOffset:)])
    {
        [self.delegate mainTableViewDidScrollWithOffset:offset];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidScroll:scrollView];
}
- (void)setContentOffset:(CGFloat)offset animated:(BOOL)animated
{
    [self.tableView setContentOffset:CGPointMake(0, offset) animated:animated];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint curRightP = [self convertPoint:point toView:self.customNavigationBar.rightButton];
    CGPoint curLeftP = [self convertPoint:point toView:self.customNavigationBar.leftBtn];
    if ([self.customNavigationBar.rightButton pointInside:curRightP withEvent:event]) {
        return self.customNavigationBar.rightButton;
    } else if ([self.customNavigationBar.leftBtn pointInside:curLeftP withEvent:event]) {
        return self.customNavigationBar.leftBtn;
    } else {
        return [super hitTest:point withEvent:event];
    }
}

#pragma mark - Lazy Init

- (YTWeatherNormalModel *)weatherModel
{
    if (!_weatherModel) {
        _weatherModel = [[YTWeatherNormalModel alloc] init];
    }
    return _weatherModel;
}

- (YTWeatherAirModel *)airModel
{
    if (!_airModel) {
        _airModel = [[YTWeatherAirModel alloc] init];
    }
    return _airModel;
}

@end
