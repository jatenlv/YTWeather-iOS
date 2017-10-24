//
//  YTMainPrecipitationTableViewCell.h
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YTWeatherHourlyForecastModel.h"

@interface YTMainPrecipitationTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray <YTWeatherHourlyForecastModel *> *hourlyModelList;

@end
