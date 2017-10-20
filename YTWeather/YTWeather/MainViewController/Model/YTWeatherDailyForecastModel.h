//
//  YTWeatherDailyForecastModel.h
//  YTWeather
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DailyAstro;
@class DailyCond;
@class DailyTmp;
@class DailyWind;

@interface YTWeatherDailyForecastModel : NSObject

@property (nonatomic, strong) DailyAstro *astro;
@property (nonatomic, strong) DailyCond *cond;
@property (nonatomic, copy)   NSString *date;
@property (nonatomic, strong) NSNumber *hum;
@property (nonatomic, strong) NSNumber *pcpn;
@property (nonatomic, strong) NSNumber *pop;
@property (nonatomic, strong) NSNumber *pres;
@property (nonatomic, strong) DailyTmp *tmp;
@property (nonatomic, strong) NSNumber *vis;
@property (nonatomic, strong) DailyWind *Wind;

@end

@interface DailyAstro : NSObject

@property (nonatomic, strong) NSNumber *mr;
@property (nonatomic, strong) NSNumber *ms;
@property (nonatomic, strong) NSNumber *sr;
@property (nonatomic, strong) NSNumber *ss;

@end

@interface DailyCond : NSObject

@property (nonatomic, strong) NSNumber *code_d;
@property (nonatomic, strong) NSNumber *code_n;
@property (nonatomic, copy)   NSString *txt_d;
@property (nonatomic, copy)   NSString *txt_n;

@end

@interface DailyTmp : NSObject

@property (nonatomic, strong) NSNumber *max;
@property (nonatomic, strong) NSNumber *min;

@end

@interface DailyWind : NSObject

@property (nonatomic, strong) NSNumber *deg;
@property (nonatomic, copy)   NSString *dir;
@property (nonatomic, copy)   NSString *sc;
@property (nonatomic, strong) NSNumber *spd;

@end
