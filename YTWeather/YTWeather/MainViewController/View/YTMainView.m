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
#import "YTMainEmptyTableViewCell.h"

#import "YTMainCustomNavigationBar.h"

#define kForecastCellHeight      500
#define kAdvertisingCellHeight   300
#define kDetailCellHeight        180
#define kMapCellHeight           200
#define kPrecipitationCellHeight 120
#define kSunAndWindCellHeight    200
#define kEmptyCellHeight         10

@interface YTMainView ()
<
UITableViewDataSource,
UITableViewDelegate,
YTMainTableHeaderViewDelegate
>

@property (nonatomic, strong)  YTMainTableHeaderView *headerView;

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
    [backImageView setImage:[UIImage imageNamed:@"cloudy_n_portrait_blur.jpg"]];
    self.tableView.backgroundView = backImageView;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerNib:[YTMainForecastTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainForecastTableViewCell className]];
    
    [self.tableView registerNib:[YTMainAdvertisingTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainAdvertisingTableViewCell className]];

    [self.tableView registerNib:[YTMainForecastTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainForecastTableViewCell className]];

    [self.tableView registerNib:[YTMainDetailTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainDetailTableViewCell className]];

    [self.tableView registerNib:[YTMainMapTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainMapTableViewCell className]];

    [self.tableView registerNib:[YTMainPrecipitationTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainPrecipitationTableViewCell className]];

    [self.tableView registerNib:[YTMainSunAndWindTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainSunAndWindTableViewCell className]];
    
    [self.tableView registerNib:[YTMainEmptyTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTMainEmptyTableViewCell className]];
    
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
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: {
            YTMainForecastTableViewCell *Forecast = [tableView dequeueReusableCellWithIdentifier:[YTMainForecastTableViewCell className]];
            return Forecast;
        } break;
            
        case 2: {
            YTMainAdvertisingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YTMainAdvertisingTableViewCell className]];
            return cell;
        } break;
        
        case 4: {
            YTMainDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YTMainDetailTableViewCell className]];
            cell.nowModel = self.weatherModel.now;
            return cell;
        } break;
            
        case 6: {
            YTMainMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YTMainMapTableViewCell className]];
            return cell;
        } break;
           
        case 8: {
            YTMainPrecipitationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YTMainPrecipitationTableViewCell className]];
            cell.hourlyModelList = self.weatherModel.hourly_forecast;
            return cell;
        } break;
            
        case 10: {
            YTMainSunAndWindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YTMainSunAndWindTableViewCell className]];
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
    self.headerView = [[YTMainTableHeaderView alloc] init];
    self.headerView.delegate = self;
    self.headerView.nowModel = self.weatherModel.now;
    self.headerView.dailyForecastModel = [self.weatherModel.daily_forecast objectAtIndex:0];
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return kForecastCellHeight;
    if (indexPath.row == 2) return kAdvertisingCellHeight;
    if (indexPath.row == 4) return kDetailCellHeight;
    if (indexPath.row == 6) return kMapCellHeight;
    if (indexPath.row == 8) return kPrecipitationCellHeight;
    if (indexPath.row == 10) return kSunAndWindCellHeight;
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

- (void)clickLeftBarButton
{
    [self.delegate clickLeftBarButton];
}

- (void)clickRightBarButton
{
    [self.delegate clickRightBarButton];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    if (offset > 0) {
        self.headerView.customNavigationBar.mj_y = offset;
    }
}
//
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    CGPoint curRightP =  [self convertPoint:point toView:self.custonNavigationBar.rightButton];
//    CGPoint curLeftP =  [self convertPoint:point toView:self.custonNavigationBar.leftBtn];
//
//    if ([self.custonNavigationBar.rightButton pointInside:curRightP withEvent:event]) {
//        return self.custonNavigationBar.rightButton;
//    }else if ([self.custonNavigationBar.leftBtn pointInside:curLeftP withEvent:event]) {
//        return self.custonNavigationBar.leftBtn;
//    }
//    else{
//        return  [super hitTest:point withEvent:event];
//    }
//}

@end
