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

//+ (void)initialize
//{
//    //防止子类重复调用
//    if([self class] == [YTCustomNavViewController class]) {
//
//        UINavigationBar * bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
//        //将背景设为透明
//        [bar setBackgroundImage:[UIImage new] forBarMetrics:(UIBarMetricsDefault)];
//        //将底线设为透明
//        [bar setShadowImage:[UIImage new]];
//        //
//        [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    }
//}
//

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
    
    // Do any additional setup after loading the view from its nib.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
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
