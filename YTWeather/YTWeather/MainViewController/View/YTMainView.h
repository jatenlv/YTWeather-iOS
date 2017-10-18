//
//  YTMainView.h
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YTMainViewDelegate <NSObject>

- (void)loadData;

@end

@interface YTMainView : UIView


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) id <YTMainViewDelegate> delegate;

@end
