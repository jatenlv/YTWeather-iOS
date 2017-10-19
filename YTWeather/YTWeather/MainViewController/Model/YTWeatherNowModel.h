//
//  YTWeatherNowModel.h
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NowCond;
@class NowWind;

@interface YTWeatherNowModel : NSObject

@property (nonatomic, strong) NowCond *cond;
@property (nonatomic, strong) NSNumber *fl;
@property (nonatomic, strong) NSNumber *hum;
@property (nonatomic, strong) NSNumber *pcpn;
@property (nonatomic, strong) NSNumber *pres;
@property (nonatomic, strong) NSNumber *tmp;
@property (nonatomic, strong) NSNumber *vis;
@property (nonatomic, strong) NowWind *wind;

@end

@interface NowCond : NSObject

@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, copy) NSString *txt;

@end

@interface NowWind : NSObject

@property (nonatomic, strong) NSNumber *deg;
@property (nonatomic, copy)   NSString *dir;
@property (nonatomic, copy)   NSString *sc;
@property (nonatomic, strong) NSNumber *spd;

@end

