//
//  YTMainMapTableViewCell.m
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainMapTableViewCell.h"

@interface YTMainMapTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backgroundContentView;

@end

@implementation YTMainMapTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.backgroundContentView.backgroundColor = MainTableViewCellColor;
    self.backgroundContentView.layer.cornerRadius = MainTableViewCellRadius;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
