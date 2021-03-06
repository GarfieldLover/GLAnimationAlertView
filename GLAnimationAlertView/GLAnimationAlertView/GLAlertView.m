//
//  GLAlertView.m
//  GLAnimationAlertView
//
//  Created by ZK on 2017/11/29.
//  Copyright © 2017年 ZK. All rights reserved.
//

#import "GLAlertView.h"
#import "GLAnimationView.h"
#import "UIView+Sizes.h"
#import "KMActivityIndicator.h"
#import "MONActivityIndicatorView.h"

static const NSInteger titleLabelSize = 16;
static const NSInteger detailLabelSize = 12;
static const NSInteger buttonSize = 12;

@interface GLAlertView ()<MONActivityIndicatorViewDelegate>

@property (nonatomic, strong) UIView* backgroundView;
@property (nonatomic, strong) GLAnimationView* animationView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* detailLabel;
@property (nonatomic, strong) UIButton* okButton;
@property (nonatomic, strong) UIButton* cancelButton;

@property (nonatomic, assign) GLAlertViewStyle style;

@end

@implementation GLAlertView

+ (void)setProgress:(CGFloat)progress {
    GLAlertView* alertView =  [GLAlertView sharedAlertView];
    
    [alertView.animationView setProgress:progress];
}

+ (instancetype)showAlertViewWithStyle:(GLAlertViewStyle)style
                                 title:(NSString *)title
                                detail:(NSString *)detail
                      canleButtonTitle:(NSString *)canle
                         okButtonTitle:(NSString *)ok
{
    GLAlertView* alertView =  [GLAlertView sharedAlertView];
    
    alertView.style = style;
    alertView.animationView.style = style;
    [alertView.okButton setTitle:ok forState:UIControlStateNormal];
    [alertView.cancelButton setTitle:canle forState:UIControlStateNormal];
    alertView.titleLabel.text = title;
    alertView.detailLabel.text = detail;
    [alertView show];
    
    return alertView;
}

+ (instancetype)sharedAlertView {
    static dispatch_once_t onceToken;
    static GLAlertView* alertView;
    dispatch_once(&onceToken, ^{
        alertView = [[GLAlertView alloc] init];
    });
    return alertView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.frame = [UIApplication sharedApplication].keyWindow.frame;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self setupBackgroundView];
    [self setupAnimationView];
    [self setupControls];
    
//    KMActivityIndicator* xx =[[KMActivityIndicator alloc] initWithFrame:self.bounds];
//    [self addSubview:xx];
//    [xx startAnimating];
    
    MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc] initWithFrame:self.bounds];
    indicatorView.delegate = self;
    indicatorView.numberOfCircles = 3;
    indicatorView.radius = 20;
    indicatorView.internalSpacing = 3;
    [indicatorView startAnimating];
    [self addSubview:indicatorView];

    [indicatorView startAnimating];


}

- (UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index {
    CGFloat red   = (arc4random() % 256)/255.0;
    CGFloat green = (arc4random() % 256)/255.0;
    CGFloat blue  = (arc4random() % 256)/255.0;
    CGFloat alpha = 1.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (void)setupBackgroundView {
    UIView* backgroundView = [UIView new];
    backgroundView.bounds = CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.width/3.0f, [UIApplication sharedApplication].keyWindow.width/3.0f);
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.cornerRadius = backgroundView.width/10.0f;
    backgroundView.layer.shadowColor = [UIColor blackColor].CGColor;
    backgroundView.layer.shadowOffset = CGSizeMake(0, 2.5f);
    backgroundView.layer.shadowOpacity = 0.25f;
    backgroundView.layer.shadowRadius = backgroundView.layer.cornerRadius;
    backgroundView.center = self.center;
    self.backgroundView = backgroundView;
    
    [self addSubview:backgroundView];
}

- (void)setupAnimationView {
    self.animationView = [[GLAnimationView alloc] initWithFrame:CGRectMake(self.backgroundView.width/4 + 10, 10, self.backgroundView.width/2 -10*2, self.backgroundView.height/2 -10*2)];
    [self.backgroundView addSubview:self.animationView];
}

- (void)setupControls {
    CGFloat x = self.backgroundView.left;
    CGFloat y = self.backgroundView.top;
    CGFloat height = self.backgroundView.height;
    CGFloat width = self.backgroundView.width;
    CGFloat XMargin = self.backgroundView.width/12.0f;
    CGFloat YMargin = 5;

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x+XMargin ,y + height / 2, width-XMargin*2, titleLabelSize)];
    [self.titleLabel setFont:[UIFont systemFontOfSize:titleLabelSize]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    self.detailLabel  = [[UILabel alloc] initWithFrame:CGRectMake(x+XMargin , self.titleLabel.bottom + YMargin, width-XMargin*2, detailLabelSize)];
    self.detailLabel.textColor = [UIColor grayColor];
    [self.detailLabel setFont:[UIFont systemFontOfSize:detailLabelSize]];
    [self.detailLabel setTextAlignment:NSTextAlignmentCenter];
    
    YMargin = 10;
    self.okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.okButton.titleLabel.font = [UIFont systemFontOfSize:buttonSize];
    self.okButton.bounds = CGRectMake(0, 0, width/3, height/7);
    self.okButton.top = self.detailLabel.bottom + YMargin;
    self.okButton.left = x+width/10.0f;
    self.okButton.layer.cornerRadius = 5;
    self.okButton.backgroundColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:255/255.0 alpha:1];

    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:buttonSize];
    self.cancelButton.bounds = CGRectMake(0, 0, width/3, height/7);
    self.cancelButton.top = self.detailLabel.bottom + YMargin;
    self.cancelButton.right = self.backgroundView.right - width/10.0f;
    self.cancelButton.layer.cornerRadius = 5;
    self.cancelButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:20/255.0 blue:20/255.0 alpha:1];

    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.okButton];
    [self addSubview:self.cancelButton];
    
    [self.okButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)show {
    if (self.superview){
        return;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self isShowControls:YES];
    [self.animationView showAnimation:YES];
}

- (void)hide {
    if (!self.superview){
        return;
    }
    
    [self.animationView showAnimation:NO];
    [self isShowControls:NO];
    [self removeFromSuperview];
}

- (void)isShowControls:(BOOL)show
{
    NSUInteger alpha = show ? 1 : 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.titleLabel.alpha = alpha;
        self.detailLabel.alpha = alpha;
        self.okButton.alpha = alpha;
        self.cancelButton.alpha = alpha;
    }];
}


- (void)buttonClick:(UIButton *)sender {
    [self hide];
}


@end
