//
//  YTMainView.h
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YTWeatherModel.h"

@protocol YTMainViewDelegate <NSObject>

- (void)loadData:(id)tagerView;

- (void)clickLeftBarButton;
- (void)clickRightBarButton;

@end

@interface YTMainView : UIView

@property (nonatomic, strong) YTWeatherModel *weatherModel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) id <YTMainViewDelegate> delegate;

@property (nonatomic, copy) NSString *cityNameForView;

@end
