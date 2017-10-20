//
//  YTWeatherAqiModel.m
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTWeatherAqiModel.h"

@implementation YTWeatherAqiModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    return [self modelInitWithCoder:aDecoder];
}

@end

@implementation CityModel

@end
