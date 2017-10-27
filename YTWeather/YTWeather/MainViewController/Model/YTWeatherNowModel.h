//
//  YTWeatherNowModel.h
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>

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
