//
//  YTMainViewController.h
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger,UIScrollViewTouchType) {
    UIScrollViewTouchTypeTap,
    UIScrollViewTouchTypeMove,
};

@interface YTMainViewController : UIViewController

@property (nonatomic, assign) UIScrollViewTouchType touchType;
@property (nonatomic, assign) BOOL isShowSlide;

@end
