//
//  YTMainSunAndWindDrawView.h
//  YTWeather
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YTWeatherDailyForecastModel.h"
#import "YTWeatherNowModel.h"

@interface YTMainSunAndWindDrawView : UIView

@property (nonatomic, strong) YTWeatherDailyForecastModel *todayModel;
@property (nonatomic, strong) YTWeatherNowModel *nowModel;

@end
