//
//  YTMainSunAndWindTableViewCell.m
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainSunAndWindTableViewCell.h"

#import "YTMainSunAndWindDrawView.h"

@interface YTMainSunAndWindTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backgroundContentView;

@property (weak, nonatomic) IBOutlet YTMainSunAndWindDrawView *drawView;

@end

@implementation YTMainSunAndWindTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.backgroundContentView.backgroundColor = MainTableViewCellColor;
    self.backgroundContentView.layer.cornerRadius = MainTableViewCellRadius;
}

- (void)setNowModel:(YTWeatherNowModel *)nowModel
{
    _nowModel = nowModel;
    self.drawView.nowModel = nowModel;
}

- (void)setAirModel:(YTWeatherAirModel *)airModel
{
    _airModel = airModel;
    self.drawView.airModel = airModel;
}

- (void)setDailyModel:(YTWeatherDailyForecastModel *)dailyModel
{
    _dailyModel = dailyModel;
    self.drawView.dailyModel = dailyModel;
}

@end
