//
//  YTDailyForecastTableViewCell.m
//  YTWeather
//
//  Created by admin on 2017/11/3.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTDailyForecastTableViewCell.h"

@interface YTDailyForecastTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *highTmpLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowTmpLabel;

@end

@implementation YTDailyForecastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setForecastModel:(YTWeatherDailyForecastModel *)forecastModel
{
    self.dayLabel.text = [NSString dateExchangeToWeek:forecastModel.date];
    self.highTmpLabel.text = [NSString stringWithFormat:@"%@°",forecastModel.tmp_max];
    self.lowTmpLabel.text = [NSString stringWithFormat:@"%@°",forecastModel.tmp_min];
    [self.weatherImageView sd_setImageWithURL:[NSURL findImageUrl:forecastModel.cond_code_d] placeholderImage:nil];
}

- (NSString *)getDateAccordingTime:(NSString *)aTime formatStyle:(NSString *)formate
{
    NSDate *nowDate = [NSDate dateWithTimeIntervalSince1970:[aTime intValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:formate];
    return[formatter stringFromDate:nowDate];
}

@end
