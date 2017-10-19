//
//  YTWeatherModel.m
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTWeatherModel.h"

@implementation YTWeatherModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    return [self modelInitWithCoder:aDecoder];
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"daily_forecast"  : [YTWeatherDailyForecastModel class],
             @"hourly_forecast" : [YTWeatherHourlyForecastModel class]
             };
}
@end
