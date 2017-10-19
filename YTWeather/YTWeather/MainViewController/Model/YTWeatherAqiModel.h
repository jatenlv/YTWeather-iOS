//
//  YTWeatherAqiModel.h
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CityDetail;

@interface YTWeatherAqiModel : NSObject

@property (nonatomic, strong) CityDetail *city;

@end

@interface CityModel : NSObject

@property (nonatomic, strong) NSNumber *aqi;
@property (nonatomic, strong) NSNumber *co;
@property (nonatomic, strong) NSNumber *no2;
@property (nonatomic, strong) NSNumber *pm10;
@property (nonatomic, strong) NSNumber *pm25;
@property (nonatomic, copy)   NSString *qlty;
@property (nonatomic, strong) NSNumber *so2;

@end

