//
//  YTMainTableHeaderView.h
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTWeatherDailyForecastModel.h"
#import "YTWeatherNowModel.h"
#import "YTWeatherBasicModel.h"

#import "YTMainCustomNavigationBar.h"

@protocol YTMainTableHeaderViewDelegate

- (void)clickLeftBarButton;
- (void)clickRightBarButton;

@end

@interface YTMainTableHeaderView : UIView

@property (nonatomic, weak) id <YTMainTableHeaderViewDelegate> delegate;

@property (nonatomic, strong) YTWeatherDailyForecastModel *dailyForecastModel;
@property (nonatomic, strong) YTWeatherNowModel *nowModel;
@property (nonatomic, strong) YTWeatherBasicModel *basicModel;

@property (weak, nonatomic) IBOutlet YTMainCustomNavigationBar *customNavigationBar;


@end
