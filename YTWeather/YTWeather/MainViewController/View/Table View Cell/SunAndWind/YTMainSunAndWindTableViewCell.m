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

@property (weak, nonatomic) IBOutlet UIImageView *windmillImageView;
@property (weak, nonatomic) IBOutlet YTMainSunAndWindDrawView *drawView;

@end

@implementation YTMainSunAndWindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundContentView.backgroundColor = MainTableViewCellColor;
    self.backgroundContentView.layer.cornerRadius = MainTableViewCellRadius;
    [self setupWindmillAnimation];
}

- (void)setupWindmillAnimation
{
    NSMutableArray *windmillArray = [NSMutableArray array];
    for (int i = 1; i < 145; i++) {
        [windmillArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"wind%d", i]]];
    }
    self.windmillImageView.animationImages = windmillArray;
    self.windmillImageView.animationDuration = 5.0;
    self.windmillImageView.animationRepeatCount = 0;
    [self.windmillImageView startAnimating];
}

- (void)drawRect:(CGRect)rect
{

}

@end
