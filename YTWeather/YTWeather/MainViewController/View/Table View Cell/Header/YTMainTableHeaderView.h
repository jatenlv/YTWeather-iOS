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

@interface YTMainTableHeaderView : UIView

@property (nonatomic, strong) YTWeatherDailyForecastModel *dailyForecastModel;
@property (nonatomic, strong) YTWeatherNowModel *nowModel;

@end
