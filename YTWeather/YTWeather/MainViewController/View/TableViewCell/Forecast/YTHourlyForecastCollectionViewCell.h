//
//  YTHourlyForecastCollectionViewCell.h
//  YTWeather
//
//  Created by admin on 2017/11/14.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YTWeatherNormalModel.h"

@interface YTHourlyForecastCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) YTWeatherHourlyForecastModel *hourlyForecastModel;

@end
