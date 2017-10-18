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

+ (void)initialize
{
    //防止子类重复调用
    if([self class] == [YTCustomNavViewController class]) {
        
        UINavigationBar * bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
        
        [bar setBackgroundColor:[UIColor blueColor]];
        // 设置透明度为0的bar
        
//        UIImage * image =
//        bar setBackgroundImage:<#(nullable UIImage *)#> forBarMetrics:<#(UIBarMetrics)#>
        //设置左边
        
        //设置rightItem
        
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
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
