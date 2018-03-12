//
//  YTWeatherNormalModel.h
//  YTWeather
//
//  Created by admin on 2018/1/24.
//  Copyright © 2018年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YTWeatherUpdateModel;
@class YTWeatherBasicModel;
@class YTWeatherDailyForecastModel;
@class YTWeatherHourlyForecastModel;
@class YTWeatherNowModel;
@class YTWeatherLifestyleModel;

@interface YTWeatherNormalModel : NSObject

@property (nonatomic, copy)   NSString * status;
@property (nonatomic, strong) YTWeatherUpdateModel *update;
@property (nonatomic, strong) YTWeatherBasicModel *basic;
@property (nonatomic, strong) NSArray <YTWeatherDailyForecastModel *> *daily_forecast;
@property (nonatomic, strong) NSArray <YTWeatherHourlyForecastModel *> *hourly;
@property (nonatomic, strong) YTWeatherNowModel *now;
@property (nonatomic, strong) NSArray <YTWeatherLifestyleModel *> *lifestyle;

@end

@interface YTWeatherUpdateModel : NSObject

@property (nonatomic, copy) NSString * loc;
@property (nonatomic, copy) NSString * utc;

@end

@interface YTWeatherBasicModel : NSObject

@property (nonatomic, copy) NSString * admin_area;
@property (nonatomic, copy) NSString * cid;
@property (nonatomic, copy) NSString * cnty;
@property (nonatomic, copy) NSString * lat;
@property (nonatomic, copy) NSString * location;
@property (nonatomic, copy) NSString * lon;
@property (nonatomic, copy) NSString * parent_city;
@property (nonatomic, copy) NSString * tz;

@end

@interface YTWeatherDailyForecastModel : NSObject

@property (nonatomic, copy) NSString * cond_code_d;
@property (nonatomic, copy) NSString * cond_code_n;
@property (nonatomic, copy) NSString * cond_txt_d;
@property (nonatomic, copy) NSString * cond_txt_n;
@property (nonatomic, copy) NSString * date;
@property (nonatomic, copy) NSString * hum;
@property (nonatomic, copy) NSString * pcpn;
@property (nonatomic, copy) NSString * pop;
@property (nonatomic, copy) NSString * pres;
@property (nonatomic, copy) NSString * tmp_max;
@property (nonatomic, copy) NSString * tmp_min;
@property (nonatomic, copy) NSString * uv_index;
@property (nonatomic, copy) NSString * vis;
@property (nonatomic, copy) NSString * wind_deg;
@property (nonatomic, copy) NSString * wind_dir;
@property (nonatomic, copy) NSString * wind_sc;
@property (nonatomic, copy) NSString * wind_spd;
@property (nonatomic, copy) NSString * sr;
@property (nonatomic, copy) NSString * ss;

@end

@interface YTWeatherHourlyForecastModel : NSObject

@property (nonatomic, copy) NSString * cloud;
@property (nonatomic, copy) NSString * cond_code;
@property (nonatomic, copy) NSString * cond_txt;
@property (nonatomic, copy) NSString * dew;
@property (nonatomic, copy) NSString * hum;
@property (nonatomic, copy) NSString * pop;
@property (nonatomic, copy) NSString * pres;
@property (nonatomic, copy) NSString * time;
@property (nonatomic, copy) NSString * tmp;
@property (nonatomic, copy) NSString * wind_deg;
@property (nonatomic, copy) NSString * wind_dir;
@property (nonatomic, copy) NSString * wind_sc;
@property (nonatomic, copy) NSString * wind_spd;

@end

@interface YTWeatherNowModel : NSObject

@property (nonatomic, copy) NSString * cloud;
@property (nonatomic, copy) NSString * cond_code;
@property (nonatomic, copy) NSString * cond_txt;
@property (nonatomic, copy) NSString * fl;
@property (nonatomic, copy) NSString * hum;
@property (nonatomic, copy) NSString * pcpn;
@property (nonatomic, copy) NSString * pres;
@property (nonatomic, copy) NSString * tmp;
@property (nonatomic, copy) NSString * vis;
@property (nonatomic, copy) NSString * wind_deg;
@property (nonatomic, copy) NSString * wind_dir;
@property (nonatomic, copy) NSString * wind_sc;
@property (nonatomic, copy) NSString * wind_spd;

@end

@interface YTWeatherLifestyleModel : NSObject

@property (nonatomic, copy) NSString * brf;
@property (nonatomic, copy) NSString * txt;
@property (nonatomic, copy) NSString * type;

@end

