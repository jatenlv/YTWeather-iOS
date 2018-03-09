//
//  YTCustomNavViewController.m
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTCustomNavViewController.h"

@interface YTCustomNavViewController ()

@end

@implementation YTCustomNavViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
}

@end
