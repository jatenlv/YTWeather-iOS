//
//  YTCustomRefreshGifHeader.h
//  YTWeather
//
//  Created by admin on 2017/10/26.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface YTCustomRefreshGifHeader : MJRefreshGifHeader

//新的下拉刷新调用
+ (instancetype)headerWithCustomerGifRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;

@end
