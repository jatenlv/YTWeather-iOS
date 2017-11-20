//
//  YTCustomRefreshGifHeader.m
//  YTWeather
//
//  Created by admin on 2017/10/26.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTCustomRefreshGifHeader.h"

#define kHeightOfHeader  64

@interface YTCustomRefreshGifHeader ()

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *bottomImageView;

@end

@implementation YTCustomRefreshGifHeader

+ (instancetype)headerWithCustomerGifRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    YTCustomRefreshGifHeader *header = [YTCustomRefreshGifHeader headerWithRefreshingBlock:refreshingBlock];
    header.backgroundColor = [UIColor clearColor];
    [header prepareCustomerGifRefresh];
    return header;
}

- (void)prepareCustomerGifRefresh
{
    NSMutableArray *headerImagesForMJRefreshStateIdle = [NSMutableArray array];
    for (int i = 1; i <= 27; i++) {
        UIImage *image = nil;
        if (i < 10) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"sun_0000%d",i]];
        } else {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"sun_000%d",i]];
        }
        [headerImagesForMJRefreshStateIdle addObject:image];
    }
    for (int i = 1; i <= 282; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"sun_00027"]];
        [headerImagesForMJRefreshStateIdle addObject:image];
    }
    
    NSMutableArray *headerImagesForMJRefreshStateRefreshing = [NSMutableArray array];
    for (int i = 28; i <= 109; i++) {
        UIImage *image = nil;
        if (i < 100){
            image = [UIImage imageNamed:[NSString stringWithFormat:@"sun_000%d",i]];
        } else {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"sun_00%d",i]];
        }
        [headerImagesForMJRefreshStateRefreshing addObject:image];
    }
    [self setImages:headerImagesForMJRefreshStateIdle duration:10.0f forState:MJRefreshStatePulling];
    [self setImages:headerImagesForMJRefreshStateRefreshing duration:2.0f forState:MJRefreshStateRefreshing];
}

- (void)prepare
{
    [super prepare];
    
    UILabel * label = [[UILabel alloc]init];
    label.text = @"下拉刷新天气...";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:11];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    [label sizeToFit];
    self.label = label;
    
    self.bottomImageView = [[UIImageView alloc] init];
    self.bottomImageView.backgroundColor = [UIColor colorWithHexString:@"#5D478B"];
    [self addSubview:self.bottomImageView];
    
    self.stateLabel.hidden = YES;
    self.lastUpdatedTimeLabel.hidden = YES;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.gifView.constraints.count) return;
    
    self.mj_h = kHeightOfHeader ;
    
    CGFloat gifW = 40.0f ;
    CGFloat gifX = self.centerX - gifW / 2;
    CGFloat gifY = kHeightOfHeader / 2 - gifW / 2;
    self.gifView.frame = CGRectMake(gifX - 50 , gifY + 5, gifW , gifW);
    self.gifView.contentMode = UIViewContentModeScaleAspectFit;

    self.label.mj_x = self.gifView.mj_x + self.gifView.mj_w + 15 ;
    self.label.centerY = self.gifView.centerY ;
    
    self.bottomImageView.frame = CGRectMake(0, kHeightOfHeader - 0.5, ScreenWidth, 0.5);
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"下拉刷新天气";
            break;
        case MJRefreshStatePulling:
            self.label.text = @"松开刷新天气";
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"正在刷新天气...";
            break;
//        case MJRefreshStateNoMoreData:
//            self.label.text = @"木有数据了(开关是打酱油滴)";
//            break;
        default:
            break;
    }
}

@end
