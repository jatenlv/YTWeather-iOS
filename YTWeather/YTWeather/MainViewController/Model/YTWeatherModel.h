//
//  YTWeatherModel.h
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YTWeatherAqiModel.h"
#import "YTWeatherBasicModel.h"
#import "YTWeatherDailyForecastModel.h"
#import "YTWeatherHourlyForecastModel.h"
#import "YTWeatherNowModel.h"
#import "YTWeatherSuggestionModel.h"

typedef NS_ENUM(NSInteger,YTWeatherDataType)
{
    YTWeatherDataTypeForecast,       // 天气预报
    YTWeatherDataTypeAdvertising,    // 广告栏
    YTWeatherDataTypeDetail,         // 详细信息
    YTWeatherDataTypeMap,            // 地图
    YTWeatherDataTypePrecipitaion,   // 降水量
    YTWeatherDataTypeSunAndWind,     // 太阳和风
};

@interface YTWeatherModel : NSObject

@property (nonatomic, strong) YTWeatherAqiModel *aqi;
@property (nonatomic, strong) YTWeatherBasicModel *basic;
@property (nonatomic, strong) NSArray <YTWeatherDailyForecastModel *> *daily_forecast;
@property (nonatomic, strong) NSArray <YTWeatherHourlyForecastModel *> *hourly_forecast;
@property (nonatomic, strong) YTWeatherNowModel *now;
@property (nonatomic, strong) YTWeatherSuggestionModel *suggestion;

@end
