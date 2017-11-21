//
//  YTShareView.m
//  YTWeather
//
//  Created by admin on 2017/11/21.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTShareView.h"

@interface YTShareView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation YTShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view =  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        view.frame = frame;
        [self addSubview:view];
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    [self.cancelButton addTarget:self action:@selector(clickCancleButton) forControlEvents:UIControlEventTouchUpInside];
}

@end
