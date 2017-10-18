//
//  YTWeatherDailyForecastListModel.h
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YTWeatherDailyForecastModel;
@class DailyAstro;
@class DailyCond;
@class DailyTemp;
@class DailyWind;

@interface YTWeatherDailyForecastListModel : NSObject

@property (nonatomic, strong) NSArray <YTWeatherDailyForecastModel *> *model;

@end

@interface YTWeatherDailyForecastModel

@property (nonatomic, strong) DailyAstro *astro;
@property (nonatomic, strong) DailyCond *cond;
@property (nonatomic, copy)   NSString *date;
@property (nonatomic, strong) NSNumber *hum;
@property (nonatomic, strong) NSNumber *pcpn;
@property (nonatomic, strong) NSNumber *pop;
@property (nonatomic, strong) NSNumber *pres;
@property (nonatomic, strong) DailyTemp *temp;
@property (nonatomic, strong) NSNumber *vis;
@property (nonatomic, strong) DailyWind *Wind;

@end

@interface DailyAstro

@property (nonatomic, strong) NSNumber *mr;
@property (nonatomic, strong) NSNumber *ms;
@property (nonatomic, strong) NSNumber *sr;
@property (nonatomic, strong) NSNumber *ss;

@end

@interface DailyCond

@property (nonatomic, strong) NSNumber *code_d;
@property (nonatomic, strong) NSNumber *code_n;
@property (nonatomic, copy)   NSString *txt_d;
@property (nonatomic, copy)   NSString *txt_n;

@end

@interface DailyTemp

@property (nonatomic, strong) NSNumber *max;
@property (nonatomic, strong) NSNumber *min;

@end

@interface DailyWind

@property (nonatomic, strong) NSNumber *deg;
@property (nonatomic, copy)   NSString *dir;
@property (nonatomic, copy)   NSString *sc;
@property (nonatomic, strong) NSNumber *spd;

@end
