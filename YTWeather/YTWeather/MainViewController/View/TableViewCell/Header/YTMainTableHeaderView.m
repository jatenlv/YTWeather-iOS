//
//  YTMainTableHeaderView.m
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainTableHeaderView.h"

@interface YTMainTableHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *currentTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *highTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowTemperatureLabel;

@property (weak, nonatomic) IBOutlet UILabel *currentStatusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *currentStatusImageView;

@end

@implementation YTMainTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view =  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        view.frame = self.bounds;
        [self addSubview:view];
    }
    return self;
}

- (void)setNowModel:(YTWeatherNowModel *)nowModel
{
    if (nowModel) {
        self.currentTemperatureLabel.text = [NSString stringWithFormat:@"%@", nowModel.tmp];
        self.currentStatusLabel.text = nowModel.cond_txt;
        [self.currentStatusImageView sd_setImageWithURL:[NSURL findImageUrl:nowModel.cond_code] placeholderImage:nil];
        [self.currentStatusImageView setImage:[self.currentStatusImageView.image imageWithColor:[UIColor whiteColor]]];

    }
}

- (void)setDailyForecastModel:(YTWeatherDailyForecastModel *)dailyForecastModel
{
    if (dailyForecastModel) {
        self.highTemperatureLabel.text = [NSString stringWithFormat:@"%@°", dailyForecastModel.tmp_max];
        self.lowTemperatureLabel.text  = [NSString stringWithFormat:@"%@°", dailyForecastModel.tmp_min];
    }
}

@end
