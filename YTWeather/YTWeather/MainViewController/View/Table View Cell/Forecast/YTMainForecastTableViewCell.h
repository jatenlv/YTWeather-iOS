//
//  YTMainForecastTableViewCell.h
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YTWeatherDailyForecastModel.h"

@interface YTMainForecastTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray <YTWeatherDailyForecastModel *> *forecastModelList;

@end
