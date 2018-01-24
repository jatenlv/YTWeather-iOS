//
//  YTMainView.h
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YTWeatherNormalModel.h"
#import "YTWeatherAirModel.h"

@protocol YTMainViewDelegate <NSObject>

- (void)refreshData:(id)tagerView;

- (void)clickLeftBarButton;
- (void)clickRightBarButton;

- (void)mainTableViewDidScrollWithOffset:(CGFloat)offset;

@end

@interface YTMainView : UIView

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) id <YTMainViewDelegate> delegate;

@property (nonatomic, copy) NSString *cityNameForView;

- (void)setWeatherAndAirModel:(YTWeatherNormalModel *)weatherModel airModel:(YTWeatherAirModel *)airModel;

- (void)setContentOffset:(CGFloat)offset animated:(BOOL)animated;

@end
