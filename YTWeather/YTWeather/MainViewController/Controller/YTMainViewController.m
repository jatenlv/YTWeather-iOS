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

@property (weak, nonatomic) IBOutlet UIView *leftSlideView;
@property (nonatomic,assign) BOOL isShowSlide;

@property (nonatomic, strong) YTWeatherModel *weatherModel;

@end

@implementation YTMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    [self addSlideGesture];

    self.weatherModel = [[YTWeatherModel alloc] init];
}

- (void)setupView
{
    self.title = @"上海";

    self.mainView = [[YTMainView alloc] initWithFrame:ScreenBounds];
    self.mainView.delegate = self;
    [self.scrollView addSubview:self.mainView];
}

#pragma mark 添加左侧侧滑手势和轻扫手势

- (void)addSlideGesture
{
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(changeFrame:)];

    [self.scrollView addGestureRecognizer:pan];
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

- (void)loadData
{
    [YTMainRequestNetworkTool requestWeatherWithCityName:@"北京" andFinish:^(YTWeatherModel *model, NSError *error) {
        [self.mainView.tableView.mj_header endRefreshing];
        if (!error) {
//            self.weatherModel = model; // 暂时无用
            self.mainView.weatherModel = model;
        }
    }];
}

/*
 * 暂时不用 以后如果需要转换再用 txt -> plist
- (void)test
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"condition-code" ofType:@"txt"];
    NSString *str = [[NSString alloc] initWithContentsOfFile:plistPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *ary = [str componentsSeparatedByString:@"\n"];
    NSMutableArray *bigAry = [NSMutableArray array];
    for (int i=1; i<ary.count-1; i++) {
        NSArray *smallAry = [ary[i] componentsSeparatedByString:@"    "];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:smallAry[0] forKey:@"cityCode"];
        [dic setObject:smallAry[1] forKey:@"cityEnglishName"];
        [dic setObject:smallAry[2] forKey:@"cityChineseName"];
        [dic setObject:smallAry[3] forKey:@"countryCode"];
        [dic setObject:smallAry[4] forKey:@"countryEnglishName"];
        [dic setObject:smallAry[5] forKey:@"countryChineseName"];
        [dic setObject:smallAry[6] forKey:@"provinceEnglishName"];
        [dic setObject:smallAry[7] forKey:@"provinceChineseName"];
        [dic setObject:smallAry[8] forKey:@"belongToCityEnglishName"];
        [dic setObject:smallAry[9] forKey:@"belongToCityChineseName"];
        [dic setObject:smallAry[10] forKey:@"cityLng"];
        [dic setObject:smallAry[11] forKey:@"cityLat"];
        [bigAry addObject:dic];
    }
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"cityCode.plist"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
        [bigAry writeToFile:fileName atomically:YES];
        NSLog(@"文件写入完成");
    }
}*/

@end
