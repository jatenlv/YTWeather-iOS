//
//  YTSwitchView.h
//  YTWeather
//
//  Created by admin on 2018/3/13.
//  Copyright © 2018年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YTSwitchViewDelegate <NSObject>

- (void)chooseSwitchWithText:(NSString *)text;

@end

@interface YTSwitchView : UIView

@property (nonatomic, copy) NSString *leftText;
@property (nonatomic, copy) NSString *rightText;

@property (nonatomic, strong) UIColor *textSelectedColor;
@property (nonatomic, strong) UIColor *textUnselectedColor;

@property (nonatomic, strong) UIColor *viewSelectedColor;
@property (nonatomic, strong) UIColor *viewUnselectedColor;

@property (nonatomic, assign) CGFloat changeSpeed;

@property (nonatomic, weak) id <YTSwitchViewDelegate> delegate;

@end
