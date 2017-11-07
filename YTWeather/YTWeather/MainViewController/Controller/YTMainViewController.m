//
//  YTMainViewController.m
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import  <CoreLocation/CoreLocation.h>

#import "YTMainViewController.h"

#import "YTSearchViewController.h"

#import "YTMainView.h"
#import "YTLeftSlideView.h"

#import "YTMainRequestNetworkTool.h"

#define kSlideWidthScale 0.7

@interface YTMainViewController ()
<
YTMainViewDelegate,
YTLeftSlideViewDelegate,
UIGestureRecognizerDelegate,
UITableViewDelegate,
CLLocationManagerDelegate
>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, assign) NSUInteger curIndex; // 当前的MainView索引
@property (nonatomic,strong) UITapGestureRecognizer *tap; // 单击手势

@property (nonatomic, strong) UIView *backAlphaView;

@property (nonatomic,strong) YTLeftSlideView *leftSlideView;
@property (nonatomic, assign) BOOL isPanGestureMove;

@property (nonatomic, strong) NSMutableArray <YTMainView *> *mainViewArray;
@property (nonatomic, strong) NSMutableArray *cityNameArray;
@property (nonatomic, assign) CGFloat viewOrginX;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *currentCity; //当前城市

@end

@implementation YTMainViewController

#pragma mark - Lift Cycle

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _curIndex = 0;
    
    [self setupBackAlphaView];   // 添加底层遮罩页面
    [self setupLeftSlideView];   // 添加左侧滑动页面
    [self setupScrollView];      // 添加ScrollView
    [self readCityNameArray];    // 取出城市缓存
    [self loadOldViewAndData];   // 加载缓存中的城市页面和数据
    [self setupLocationManager]; // 加载定位功能
    [self addSlideGesture];      // 添加滑动弹出设置页面手势
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchCityNameDidSelect:) name:YTNotificationSearchCityNameDidSelect object:nil];
}

#pragma mark - Private Method

- (void)setupBackAlphaView
{
    self.backAlphaView = [[UIView alloc] initWithFrame:ScreenBounds];
    self.backAlphaView.backgroundColor = [UIColor colorWithHexString:@"#151515"];
    [self.view addSubview:self.backAlphaView];
}

- (void)setupLeftSlideView
{
    self.leftSlideView = [[YTLeftSlideView alloc]initWithFrame:ScreenBounds];
    self.leftSlideView.delegate = self;
    [self.view addSubview:self.leftSlideView];
    [self.view sendSubviewToBack:self.leftSlideView];
}

- (void)setupScrollView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:ScreenBounds];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
}

- (void)readCityNameArray
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.cityNameArray = [[defaults objectForKey:YTCityNameArrayDefaults] mutableCopy];
    if (self.cityNameArray.count == 0) {
        if (!self.cityNameArray) {
            self.cityNameArray = [NSMutableArray array];
        }
        [self.cityNameArray addObject:@"上海"];
    }
}

- (void)loadOldViewAndData
{
    // 调整scrollView大小
    [self reloadScrollViewSize];
    self.mainViewArray = [NSMutableArray array];
    self.viewOrginX = 0;
    for (NSString *cityName in self.cityNameArray) {
        [self createMainViewWithCityName:cityName newView:NO];
    }
    self.leftSlideView.kCityNameArray = [self.cityNameArray mutableCopy];
}

- (void)reloadScrollViewSize
{
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.cityNameArray.count * ScreenWidth, 0);
}

// 创建新页面及数据
- (void)createMainViewWithCityName:(NSString *)cityName newView:(BOOL)newView
{
    // 加载view
    YTMainView *mainView = [[YTMainView alloc] initWithFrame:CGRectMake(self.viewOrginX, 0, ScreenWidth, ScreenHeight)];
    mainView.cityNameForView = cityName;
    mainView.delegate = self;
    [self.scrollView addSubview:mainView];
    [self.mainViewArray addObject:mainView];
    self.viewOrginX += ScreenWidth;
    // 加载model
    [YTMainRequestNetworkTool requestWeatherAndAirWithCityName:cityName viewController:self andFinish:^(YTWeatherModel *weatherModel, YTWeatherAirModel *airModel, NSError *error) {
        if (!error) {
            if ([mainView.cityNameForView isEqualToString:cityName]) {
                [mainView setWeatherAndAirModel:weatherModel airModel:airModel];
            }
        }
    }];
    
    if (newView) {
        [self.scrollView setContentOffset:mainView.frame.origin animated:NO];
    }
}

- (void)setupLocationManager
{
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager requestAlwaysAuthorization];
        self.currentCity = [[NSString alloc] init];
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark - Notification

- (void)searchCityNameDidSelect:(NSNotification *)notify
{
    NSString *newCityName = notify.object;
    
    for (NSString *cityName in self.cityNameArray) {
        if ([cityName isEqualToString:newCityName]) {
            NSInteger index = [self.cityNameArray indexOfObject:cityName];
            [self.scrollView setContentOffset:CGPointMake(index * ScreenWidth, 0)];
            return;
        }
    }

    [self.cityNameArray addObject:newCityName];
    [self saveCityNameArray:[_cityNameArray copy]]; // 存入缓存
    
    [self reloadScrollViewSize];
    [self createMainViewWithCityName:newCityName newView:YES];
    self.leftSlideView.kCityNameArray = [self.cityNameArray mutableCopy];
}

#pragma mark - 添加左侧侧滑手势

- (void)addSlideGesture
{
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(changeFrame:)];
    pan.delegate = self;
    [self.scrollView addGestureRecognizer:pan];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLeftBarButton)];
    [tap requireGestureRecognizerToFail:pan];
    self.tap = tap;
    [self addObserver:self forKeyPath:@"isShowSlide" options:NSKeyValueObservingOptionNew context:nil];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    [self getCurMainVConfigScrollEnabled];
    return _isShowSlide;
}
- (void)getCurMainVConfigScrollEnabled
{
    YTMainView * curMainV =self.mainViewArray[_curIndex];
    curMainV.tableView.scrollEnabled = !_isShowSlide;
}

- (void)changeFrame:(UIPanGestureRecognizer *)pan
{
    //相对偏移量
    CGFloat translatePointX = [pan translationInView:self.scrollView].x;
    if(self.scrollView.mj_x + translatePointX < 0) {
        translatePointX = 0;
    }
    if(pan.state == UIGestureRecognizerStateChanged) {
        [self slideViewMoveWithDistance:translatePointX];

    } else if(pan.state == UIGestureRecognizerStateEnded) {
        if(self.scrollView.mj_x < kSlideWidthScale * ScreenWidth) {
            [self slideViewMoveWithDistance:-self.scrollView.mj_x];
            self.isShowSlide = NO;
        } else {
            [self slideViewMoveWithDistance: (kSlideWidthScale * ScreenWidth-self.scrollView.mj_x)];
        }
    }
    [pan setTranslation:CGPointZero inView:self.scrollView];
}

- (void)slideViewMoveWithDistance:(CGFloat)offset
{
    [UIView animateWithDuration:0.35 animations:^{
        self.scrollView.mj_x += offset;
    }];
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    _curIndex = offset/ScreenWidth;
}

#pragma mark - CoreLocation Delegate

//定位失败则执行此代理方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    } else if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}

//定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"%lu",(unsigned long)locations.count);
    CLLocation * location = locations.lastObject;
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];

    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            // 获取城市
            NSString *city = placemark.locality;
            if (!city) {
            // 四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
            city = placemark.administrativeArea;
            }
            NSLog(@"city,%@",city);
        } else if (error == nil && [placemarks count] == 0) {
            NSLog(@"No results were returned.");
        } else if (error != nil){
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //    [manager stopUpdatingLocation];不用的时候关闭更新位置服务
}

#pragma mark - YTMainView Delegate

- (void)refreshData:(id)tagerView
{
    YTMainView *mainView = (YTMainView *)tagerView;
    
    [YTMainRequestNetworkTool requestWeatherAndAirWithCityName:mainView.cityNameForView viewController:self andFinish:^(YTWeatherModel *weatherModel, YTWeatherAirModel *airModel, NSError *error) {
        [mainView.tableView.mj_header endRefreshing];
        if (!error) {
            [mainView setWeatherAndAirModel:weatherModel airModel:airModel];
        }
    }];
}

- (void)clickLeftBarButton
{
    CGFloat maxOffset = kSlideWidthScale * self.scrollView.width;
    CGFloat offset = _isShowSlide ? -maxOffset : maxOffset;
    [self slideViewMoveWithDistance:offset];
    self.isShowSlide = !self.isShowSlide;
    if (self.isShowSlide) {
        [UIView animateWithDuration:0.43 animations:^{
            self.backAlphaView.alpha = 0;
        }];
    } else {
        [UIView animateWithDuration:0.6 animations:^{
            self.backAlphaView.alpha = 1;
        }];
    }
}

- (void)clickRightBarButton
{
    YTSearchViewController *resultVC = [[YTSearchViewController alloc] init];
    [self presentViewController:resultVC animated:YES completion:nil];
}

- (void)mainTableViewDidScrollWithOffset:(CGFloat)offset
{
    [self.mainViewArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(_curIndex != idx)
        {
            YTMainView * mainV = (YTMainView *)obj;
            [mainV setContentOffset:offset animated:NO];
        }
    }];
}

#pragma mark - YTLeftSlideView Delegate

- (void)showCityViewWithIndex:(NSInteger)index
{
    [self clickLeftBarButton];
    [self.scrollView setContentOffset:self.mainViewArray[index].frame.origin animated:NO];
}

- (void)deleteCityViewWithIndex:(NSInteger)index
{
    [self.cityNameArray removeObjectAtIndex:index];
    [self saveCityNameArray:[_cityNameArray copy]]; // 存入缓存
    
    [[self.mainViewArray objectAtIndex:index] removeFromSuperview];
    [self.mainViewArray removeObjectAtIndex:index];
    for (NSInteger i = index; i < self.mainViewArray.count; i++) {
        [[self.mainViewArray objectAtIndex:i] setFrame:CGRectMake([self.mainViewArray objectAtIndex:i].mj_x - ScreenWidth, 0, ScreenWidth, ScreenHeight)];
    }
    
    if (self.curIndex > index) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x - ScreenWidth, 0) animated:YES];
    }
    
    [self.scrollView layoutSubviews];
    [self reloadScrollViewSize];
    self.curIndex = self.scrollView.contentOffset.x / ScreenWidth;
}

#pragma mark - 存缓存操作

- (void)saveCityNameArray:(NSArray *)cityNameArray
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:cityNameArray forKey:YTCityNameArrayDefaults];
    [defaults synchronize];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    BOOL isAddTapGesture = [change[NSKeyValueChangeNewKey] boolValue];
    if(isAddTapGesture){
        [self.scrollView addGestureRecognizer:self.tap];
    }else{
        [self.scrollView removeGestureRecognizer:self.tap];
    }
}

@end
