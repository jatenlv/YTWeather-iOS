//
//  YTWeatherDailyForecastModel.h
//  YTWeather
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end
