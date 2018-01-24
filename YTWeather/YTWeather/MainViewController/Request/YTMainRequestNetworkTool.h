//
//  YTMainRequestNetworkTool.h
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YTWeatherNormalModel.h"
#import "YTWeatherAirModel.h"

@interface YTMainRequestNetworkTool : NSObject

+ (void)requestWeatherAndAirWithCityName:(NSString *)cityName viewController:(UIViewController *)vc andFinish:(void (^)(YTWeatherNormalModel *weatherModel, YTWeatherAirModel *airModel, NSError *error))finish;

@end
