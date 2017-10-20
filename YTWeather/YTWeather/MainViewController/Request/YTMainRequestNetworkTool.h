//
//  YTMainRequestNetworkTool.h
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTWeatherModel.h"

@interface YTMainRequestNetworkTool : NSObject

+ (void)requestWeatherWithCityName:(NSString *)cityName
                          andFinish:(void(^)(YTWeatherModel *model, NSError *error))finish;

+ (NSArray *)requestDateForLeftSlideView;


@end
