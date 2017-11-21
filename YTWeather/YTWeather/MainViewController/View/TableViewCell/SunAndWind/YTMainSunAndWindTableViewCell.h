//
//  YTMainSunAndWindTableViewCell.h
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YTWeatherNowModel.h"
#import "YTWeatherAirModel.h"

@interface YTMainSunAndWindTableViewCell : UITableViewCell

@property (nonatomic, strong) YTWeatherNowModel *nowModel;
@property (nonatomic, strong) YTWeatherAirModel *airModel;
@end
