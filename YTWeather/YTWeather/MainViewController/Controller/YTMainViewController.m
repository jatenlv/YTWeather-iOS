//
//  YTMainViewController.m
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainViewController.h"

#import "YTMainView.h"

#import "YTWeatherModel.h"

#import "YTMainRequestNetworkTool.h"

@interface YTMainViewController ()
<
YTMainViewDelegate
>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) YTMainView *mainView;

@property (nonatomic, strong) YTWeatherModel *weatherModel;

@end

@implementation YTMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"上海";
    
    YTMainView *mainView = [[YTMainView alloc] initWithFrame:ScreenBounds];
    [self.scrollView addSubview:mainView];
    [self setupView];
    self.weatherModel = [[YTWeatherModel alloc] init];
}

- (void)setupView
{
    self.mainView = [[YTMainView alloc] initWithFrame:ScreenBounds];
    self.mainView.delegate = self;
    [self.scrollView addSubview:self.mainView];

}

- (void)loadData
{
    [YTMainRequestNetworkTool requestWeatherWithCityName:@"北京" andFinish:^(YTWeatherModel *model, NSError *error) {
        [self.mainView.tableView.mj_header endRefreshing];
        if (!error) {
            self.weatherModel = model;
        }
    }];
}

@end
