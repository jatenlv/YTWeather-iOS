//
//  YTSettingNormalTableViewCell.h
//  YTWeather
//
//  Created by admin on 2018/3/13.
//  Copyright © 2018年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YTSettingNormalTableViewCellDelegate <NSObject>

- (void)switchTempWithText:(NSString *)text;

@end

@interface YTSettingNormalTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *switchLeftText;
@property (nonatomic, copy) NSString *switchRightText;

@property (nonatomic, weak) id <YTSettingNormalTableViewCellDelegate> delegate;

@end
