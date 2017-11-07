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

+ (void)requestWeatherWithCityName:(NSString *)cityName viewController:(UIViewController *)vc andFinish:(void (^)(YTWeatherModel *model, NSError *))finish;

@end
