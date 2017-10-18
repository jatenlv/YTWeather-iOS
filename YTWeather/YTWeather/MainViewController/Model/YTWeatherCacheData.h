//
//  YTWeatherCacheData.h
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTWeatherCacheData : NSObject

typedef NS_ENUM(NSInteger,YTWeatherDataType)
{
    YTWeatherDataTypeForecast,       // 天气预报
    YTWeatherDataTypeAdvertising,    // 广告栏
    YTWeatherDataTypeDetail,         // 详细信息
    YTWeatherDataTypeMap,            // 地图
    YTWeatherDataTypePrecipitaion,   // 降水量
    YTWeatherDataTypeSunAndWind,     // 太阳和风
};

@end
