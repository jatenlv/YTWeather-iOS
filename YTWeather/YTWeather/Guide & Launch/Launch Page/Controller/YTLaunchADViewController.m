//
//  YTLaunchADViewController.m
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTLaunchADViewController.h"

#import "YTMainViewController.h"
#import "YTCustomNavViewController.h"

static int resetSeconds = 3;

@interface YTLaunchADViewController ()

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (nonatomic,weak) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation YTLaunchADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTimer];
}

- (void)setupTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(closeBtnTitleChangeByTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
    [timer fire];
}

- (void)closeBtnTitleChangeByTime
{
    if(resetSeconds < 0)
    {
        [self forwardToMainVC:nil];
        return;
    }
    NSString * title = [NSString stringWithFormat:@"跳过%d秒",resetSeconds];
    [self.closeBtn setTitle:title forState:UIControlStateNormal];
    self.closeBtn.backgroundColor = [UIColor clearColor];
    resetSeconds--;
}

- (IBAction)forwardToMainVC:(id)sender
{
    [self.timer invalidate];
    self.timer = nil;
    YTMainViewController * mainVC = [[YTMainViewController alloc]init];
    YTCustomNavViewController * navVc = [[YTCustomNavViewController alloc]initWithRootViewController:mainVC];
    [self.navigationController pushViewController:navVc animated:NO];
    [UIApplication sharedApplication].keyWindow.rootViewController = navVc;
}

@end
