//
//  YTWeatherHourlyForecastListModel.h
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YTWeatherHourlyForecastModel;
@class HourlyCond;
@class HourlyWind;

@interface YTWeatherHourlyForecastListModel : NSObject

@property (nonatomic, strong) NSArray <YTWeatherHourlyForecastModel *> *model;

@end

@interface YTWeatherHourlyForecastModel

@property (nonatomic, strong) HourlyCond *cond;
@property (nonatomic, copy)   NSString *date;
@property (nonatomic, strong) NSNumber *hum;
@property (nonatomic, strong) NSNumber *pop;
@property (nonatomic, strong) NSNumber *pres;
@property (nonatomic, strong) NSNumber *tmp;
@property (nonatomic, strong) HourlyWind *Wind;

@end

@interface HourlyCond

@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, strong) NSNumber *txt;

@end

@interface HourlyWind

@property (nonatomic, strong) NSNumber *deg;
@property (nonatomic, copy)   NSString *dir;
@property (nonatomic, copy)   NSString *sc;
@property (nonatomic, strong) NSNumber *spd;

@end
