//
//  YTSwitchView.m
//  YTWeather
//
//  Created by admin on 2018/3/13.
//  Copyright © 2018年 Jaten. All rights reserved.
//

#import "YTSwitchView.h"

@interface YTSwitchView ()

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation YTSwitchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view =  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        view.frame = self.bounds;
        view.width = ScreenWidth;
        [self addSubview:view];
        self.layer.cornerRadius = 10.f;
        
        [self defaultConfig];
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *view =  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        view.frame = self.bounds;
        view.width = ScreenWidth;
        [self addSubview:view];
        self.layer.cornerRadius = 10.f;
        
        [self defaultConfig];
        [self setup];
    }
    return self;
}

- (void)defaultConfig
{
    self.textSelectedColor = [UIColor blackColor];
    self.textUnselectedColor = [UIColor whiteColor];
    
    self.viewSelectedColor = [UIColor yellowColor];
    self.viewUnselectedColor = [UIColor lightGrayColor];

    self.changeSpeed = 2.f;
}

- (void)setup
{
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [self addGestureRecognizer:self.tapGesture];
}

- (void)tapView:(UITapGestureRecognizer *)tap
{
    if (tap.view == self.leftView) {
        [self leftViewSelected];
    } else if (tap.view == self.rightView) {
        [self rightViewSelected];
    }
}

- (void)leftViewSelected
{
    self.leftLabel.textColor = self.textSelectedColor;
    self.leftView.backgroundColor = self.viewSelectedColor;

    self.rightLabel.textColor = self.textUnselectedColor;
    self.rightView.backgroundColor = self.viewUnselectedColor;
    
    [self.delegate chooseSwitchWithText:self.leftText];
}

- (void)rightViewSelected
{
    self.leftLabel.textColor = self.textUnselectedColor;
    self.leftView.backgroundColor = self.viewUnselectedColor;
    
    self.rightLabel.textColor = self.textSelectedColor;
    self.rightView.backgroundColor = self.viewSelectedColor;
    
    [self.delegate chooseSwitchWithText:self.rightText];
}

@end
