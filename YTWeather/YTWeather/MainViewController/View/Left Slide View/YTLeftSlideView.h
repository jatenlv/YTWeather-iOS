//
//  YTLeftSlideView.h
//  YTWeather
//
//  Created by admin on 2017/11/1.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YTLeftSlideViewDelegate

- (void)showCityViewWithIndex:(NSInteger)index;

@end

@interface YTLeftSlideView : UIView

@property (nonatomic, weak) id <YTLeftSlideView> delegate;

@property (nonatomic, strong) NSArray *cityNameArray;

@end
