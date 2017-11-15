//
//  YTMainDetailTableViewCell.m
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainDetailTableViewCell.h"

@interface YTMainDetailTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backgroundContentView;
@property (weak, nonatomic) IBOutlet UILabel *bodyTmp;
@property (weak, nonatomic) IBOutlet UILabel *wet;
@property (weak, nonatomic) IBOutlet UILabel *visibility;
@property (weak, nonatomic) IBOutlet UILabel *pressure;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;

@end

@implementation YTMainDetailTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.backgroundContentView.backgroundColor = MainTableViewCellColor;
    self.backgroundContentView.layer.cornerRadius = MainTableViewCellRadius;
}

- (void)setNowModel:(YTWeatherNowModel *)nowModel
{
    self.bodyTmp.text    = [NSString stringWithFormat:@"%@°", nowModel.fl];
    self.wet.text        = [NSString stringWithFormat:@"%@%%", nowModel.hum];
    self.visibility.text = [NSString stringWithFormat:@"%@公里", nowModel.vis];
    [self.weatherImageView sd_setImageWithURL:[NSURL findImageUrl:nowModel.cond_code] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self.weatherImageView setImage:[self.weatherImageView.image imageWithColor:[UIColor whiteColor]]];
    }];
}

- (void)setAirNowModel:(YTWeatherAirModel *)airNowModel
{
    self.pressure.text   = [NSString stringWithFormat:@"%@", airNowModel.air_now_city.pm25];
}

@end
