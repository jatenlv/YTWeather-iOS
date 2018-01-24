//
//  YTMainSunAndWindDrawView.h
//  YTWeather
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YTWeatherNormalModel.h"
#import "YTWeatherAirModel.h"

@interface YTMainSunAndWindDrawView : UIView

@property (nonatomic, strong) YTWeatherNowModel *nowModel;
@property (nonatomic, strong) YTWeatherAirModel *airModel;

@end
