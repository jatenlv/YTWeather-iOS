//
//  YTMainCustomNavigationBar.h
//  YTWeather
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBarButton)(void);

@interface YTMainCustomNavigationBar : UIView

@property(nonatomic, strong) ClickBarButton clickLeftBarButton;
@property(nonatomic, strong) ClickBarButton clickRightBarButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end
