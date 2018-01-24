//
//  YTHourlyForecastCollectionViewCell.m
//  YTWeather
//
//  Created by admin on 2017/11/14.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTHourlyForecastCollectionViewCell.h"

@interface YTHourlyForecastCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *tmpLabel;

@end

@implementation YTHourlyForecastCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setHourlyForecastModel:(YTWeatherHourlyForecastModel *)hourlyForecastModel
{
    self.timeLabel.text = [NSString stringWithFormat:@"%@时",[hourlyForecastModel.time substringWithRange:NSMakeRange(hourlyForecastModel.time.length - 5, 2)]];
    [self.weatherImageView sd_setImageWithURL:[NSURL findImageUrl:hourlyForecastModel.cond_code] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self.weatherImageView setImage:[self.weatherImageView.image imageWithColor:[UIColor whiteColor]]];
    }];
    self.tmpLabel.text  = [NSString stringWithFormat:@"%@°", hourlyForecastModel.tmp];
}

@end
