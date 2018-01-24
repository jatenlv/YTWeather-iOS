//
//  YTWeatherNormalModel.m
//  YTWeather
//
//  Created by admin on 2018/1/24.
//  Copyright © 2018年 Jaten. All rights reserved.
//

#import "YTWeatherNormalModel.h"

@implementation YTWeatherNormalModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"daily_forecast" : [YTWeatherDailyForecastModel class],
             @"hourly"         : [YTWeatherHourlyForecastModel class],
             @"lifestyle"      : [YTWeatherLifestyleModel class]
             };
}

@end

@implementation YTWeatherUpdateModel

@end

@implementation YTWeatherBasicModel

@end

@implementation YTWeatherDailyForecastModel

@end

@implementation YTWeatherHourlyForecastModel

@end

@implementation YTWeatherNowModel

@end

@implementation YTWeatherLifestyleModel

@end

