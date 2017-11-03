//
//  YTWeatherModel.h
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YTWeatherUpdateModel.h"
#import "YTWeatherBasicModel.h"
#import "YTWeatherDailyForecastModel.h"
#import "YTWeatherHourlyForecastModel.h"
#import "YTWeatherNowModel.h"
#import "YTWeatherLifestyleModel.h"

@interface YTWeatherModel : NSObject

@property (nonatomic, copy)   NSString * status;
@property (nonatomic, strong) YTWeatherUpdateModel *update;
@property (nonatomic, strong) YTWeatherBasicModel *basic;
@property (nonatomic, strong) NSArray <YTWeatherDailyForecastModel *> *daily_forecast;
@property (nonatomic, strong) NSArray <YTWeatherHourlyForecastModel *> *hourly;
@property (nonatomic, strong) YTWeatherNowModel *now;
@property (nonatomic, strong) NSArray <YTWeatherLifestyleModel *> *lifestyle;

@end
