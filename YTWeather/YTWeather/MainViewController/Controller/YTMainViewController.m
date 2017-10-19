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

#import "YTMainRequestNetworkTool.h"

#define kSlideWidthScale 0.7

@interface YTMainViewController ()
<
YTMainViewDelegate
>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) YTMainView *mainView;

@property (nonatomic, strong) YTWeatherModel *weatherModel;
@property (weak, nonatomic) IBOutlet UIView *leftSlideView;
@property (nonatomic,assign) BOOL isShowSlide;

@end

@implementation YTMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"上海";
    
    YTMainView *mainView = [[YTMainView alloc] initWithFrame:ScreenBounds];
    [self.scrollView addSubview:mainView];
    [self setupView];
    self.weatherModel = [[YTWeatherModel alloc] init];
    
    [self addSlideGesture];
    
}

- (void)setupView
{
    self.mainView = [[YTMainView alloc] initWithFrame:ScreenBounds];
    self.mainView.delegate = self;
    [self.scrollView addSubview:self.mainView];

}
#pragma mark 添加左侧侧滑手势和轻扫手势
- (void)addSlideGesture
{
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(changeFrame:)];
    [self.scrollView addGestureRecognizer:pan];
//    UISwipeGestureRecognizer * swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showSlideView:)];
//    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//    [self.scrollView addGestureRecognizer:swipeLeft];
//    UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showSlideView:)];
//    [self.scrollView addGestureRecognizer:swipeRight];

//    [swipeLeft requireGestureRecognizerToFail:pan];
//    [swipeRight requireGestureRecognizerToFail:pan];

    
}
- (void)changeFrame:(UIPanGestureRecognizer *)pan
{
    //相对偏移量
    __block  CGFloat  translatePointX = [pan translationInView:self.scrollView].x;
    CGFloat scrollX = self.scrollView.frame.origin.x;
    
    
    // 左滑滑动范围
    if(self.scrollView.frame.origin.x + translatePointX< 0)
    {
        translatePointX = -self.scrollView.frame.origin.x;
        //右滑滑动范围
    }else if(scrollX + translatePointX > kSlideWidthScale * self.scrollView.width) {
        
        translatePointX =  kSlideWidthScale * self.scrollView.width - self.scrollView.frame.origin.x;
    }
    self.scrollView.centerX += translatePointX;
    self.leftSlideView.centerX += translatePointX;
    if(pan.state == UIGestureRecognizerStateChanged)
    {
        NSLog(@"change");
    }else if(pan.state == UIGestureRecognizerStateEnded)
    {
        if(scrollX >= kSlideWidthScale/2 * self.scrollView.width )
        {
            translatePointX = kSlideWidthScale * self.scrollView.width - scrollX;

            [UIView animateWithDuration:0.35 animations:^{
                self.scrollView.centerX += translatePointX;
                self.leftSlideView.centerX += translatePointX;
            }];
            _isShowSlide = YES;
        }
        else {
            translatePointX = -scrollX;
            [UIView animateWithDuration:0.35 animations:^{
                self.scrollView.centerX += translatePointX;
                self.leftSlideView.centerX += translatePointX;
            }];
            _isShowSlide = NO;
        }
    }
   
    [pan setTranslation:CGPointZero inView:self.scrollView];
}
//#pragma mark 扫滑手势方法
//- (void)showSlideView:(UISwipeGestureRecognizer *)swip
//{
//    CGFloat offset = kSlideWidthScale*self.scrollView.width;
//    switch (swip.direction) {
//        case UISwipeGestureRecognizerDirectionRight:{
//            if(!_isShowSlide)
//            {
//                [UIView animateWithDuration:0.35 animations:^{
//                    self.scrollView.centerX += offset;
//                    self.leftSlideView.centerX += offset;
//                }];
//                _isShowSlide = YES;
//            }
//            break;
//        }
//        case UISwipeGestureRecognizerDirectionLeft:
//            if(_isShowSlide)
//            {
//                [UIView animateWithDuration:0.35 animations:^{
//                    self.scrollView.centerX += -offset;
//                    self.leftSlideView.centerX += -offset;
//                }];
//                _isShowSlide = NO;
//            }
//            break;
//        case UISwipeGestureRecognizerDirectionUp:
//            NSLog(@"up");
//            break;
//        case UISwipeGestureRecognizerDirectionDown:
//            NSLog(@"down");
//            break;
//        default:
//            break;
//    }
//
//}
- (void)loadData
{
    [YTMainRequestNetworkTool requestWeatherWithCityName:@"北京" andFinish:^(YTWeatherModel *model, NSError *error) {
        [self.mainView.tableView.mj_header endRefreshing];
        if (!error) {
            self.weatherModel = model; // 暂时无用
            self.mainView.weatherModel = model;
        }
    }];
}

@end
