//
//  YTWeatherModel.m
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTWeatherModel.h"

@implementation YTWeatherModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"daily_forecast" : [YTWeatherDailyForecastModel class],
             @"hourly"         : [YTWeatherHourlyForecastModel class],
             @"lifestyle"      : [YTWeatherLifestyleModel class]
             };
}

@end
