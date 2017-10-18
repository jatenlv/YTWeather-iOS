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


@end

@implementation YTLaunchADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view from its nib.
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"这是广告页" forState:(UIControlStateNormal)];
    [btn sizeToFit];
    btn.center = self.view.center;
    [self.view addSubview:btn];

    NSTimer * timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(closeBtnTitleChangeByTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
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
    resetSeconds--;
    
    
}

- (IBAction)forwardToMainVC:(id)sender {
    [self.timer invalidate];
    self.timer = nil;
    YTMainViewController * mainVC = [[YTMainViewController alloc]init];
    YTCustomNavViewController * navVc = [[YTCustomNavViewController alloc]initWithRootViewController:mainVC];
    [self.navigationController pushViewController:navVc animated:NO];
    [UIApplication sharedApplication].keyWindow.rootViewController = navVc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
