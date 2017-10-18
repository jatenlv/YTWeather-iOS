//
//  YTMainViewController.m
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainViewController.h"

#import "YTMainView.h"

#import "YTWeatherModel.h"
#import "YTWeatherCacheData.h"

#import "YTMainRequestNetworkTool.h"

@interface YTMainViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation YTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    YTMainView *mainView = [[YTMainView alloc] initWithFrame:ScreenBounds];
    [self.scrollView addSubview:mainView];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

@end
