//
//  YTMainDetailTableViewCell.m
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainDetailTableViewCell.h"

@implementation YTMainDetailTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.backgroundColor = MainTableViewCellColor;
    self.layer.cornerRadius = MainTableViewCellRadius;
}

@end
