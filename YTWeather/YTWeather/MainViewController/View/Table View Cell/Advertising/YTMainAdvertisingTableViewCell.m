//
//  YTMainAdvertisingTableViewCell.m
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainAdvertisingTableViewCell.h"

@interface YTMainAdvertisingTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *adImageView;

@end

@implementation YTMainAdvertisingTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = MainTableViewCellColor;
    self.layer.cornerRadius = MainTableViewCellRadius;
}

@end