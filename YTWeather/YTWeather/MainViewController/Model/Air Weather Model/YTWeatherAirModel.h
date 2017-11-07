//
//  YTWeatherAirModel.h
//  YTWeather
//
//  Created by admin on 2017/11/7.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AirNowCity;

@interface YTWeatherAirModel : NSObject

@property (nonatomic, strong) AirNowCity *air_now_city;

@end

@interface AirNowCity : NSObject

@property (nonatomic, strong) NSString * aqi;
@property (nonatomic, strong) NSString * co;
@property (nonatomic, strong) NSString * main;
@property (nonatomic, strong) NSString * no2;
@property (nonatomic, strong) NSString * o3;
@property (nonatomic, strong) NSString * pm10;
@property (nonatomic, strong) NSString * pm25;
@property (nonatomic, strong) NSString * pubTime;
@property (nonatomic, strong) NSString * qlty;
@property (nonatomic, strong) NSString * so2;

@end
