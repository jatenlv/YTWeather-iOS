//
//  YTDailyForecastTableViewCell.h
//  YTWeather
//
//  Created by admin on 2017/11/3.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YTWeatherDailyForecastModel.h"

@interface YTDailyForecastTableViewCell : UITableViewCell

@property (nonatomic, strong) YTWeatherDailyForecastModel *forecastModel;

@end
