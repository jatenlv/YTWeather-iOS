//
//  YTMainPrecipitationTableViewCell.m
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainPrecipitationTableViewCell.h"

@interface YTMainPrecipitationTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backgroundContentView;
@property (weak, nonatomic) IBOutlet UILabel *firstTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstPreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UILabel *secondTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *SecondPreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UILabel *thirdTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdPreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;

@end

@implementation YTMainPrecipitationTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundContentView.backgroundColor = MainTableViewCellColor;
    self.backgroundContentView.layer.cornerRadius = MainTableViewCellRadius;
}

- (void)setHourlyModelList:(NSArray<YTWeatherHourlyForecastModel *> *)hourlyModelList
{
    if (hourlyModelList.count >= 1) {
        self.firstTimeLabel.text = [self cutTheDate:hourlyModelList[0].time];
        self.firstPreLabel.text  = [NSString stringWithFormat:@"%@%%", hourlyModelList[0].pop];
        if ([hourlyModelList[0].pop integerValue] > 0) {
            self.firstImageView.image = [UIImage imageNamed:@"raindrop_blue"];
        }
    }
    if (hourlyModelList.count >= 2) {
        self.secondTimeLabel.text = [self cutTheDate:hourlyModelList[1].time];
        self.SecondPreLabel.text  = [NSString stringWithFormat:@"%@%%", hourlyModelList[1].pop];
        if ([hourlyModelList[1].pop integerValue] > 0) {
            self.secondImageView.image = [UIImage imageNamed:@"raindrop_blue"];
        }
    }
    if (hourlyModelList.count >= 3) {
        self.thirdTimeLabel.text = [self cutTheDate:hourlyModelList[2].time];
        self.thirdPreLabel.text  = [NSString stringWithFormat:@"%@%%", hourlyModelList[2].pop];
        if ([hourlyModelList[2].pop integerValue] > 0) {
            self.thirdImageView.image = [UIImage imageNamed:@"raindrop_blue"];
        }
    }
}

- (NSString *)cutTheDate:(NSString *)dateStr
{
    return [dateStr substringFromIndex:dateStr.length - 5];
}

@end
