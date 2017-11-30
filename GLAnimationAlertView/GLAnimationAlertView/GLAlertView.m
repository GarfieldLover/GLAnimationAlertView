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

static const NSInteger titleLabelSize = 20;
static const NSInteger detailLabelSize = 20;
static const NSInteger buttonSize = 20;

@interface GLAlertView ()

@property (nonatomic, strong) GLAnimationView* animationView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* detailLabel;
@property (nonatomic, strong) UIButton* okButton;
@property (nonatomic, strong) UIButton* cancelButton;

@property (nonatomic, assign) GLAlertViewStyle style;

@end

@implementation GLAlertView


+ (instancetype)showAlertViewWithStyle:(GLAlertViewStyle)style
                                 title:(NSString *)title
                                detail:(NSString *)detail
                      canleButtonTitle:(NSString *)canle
                         okButtonTitle:(NSString *)ok
{
    GLAlertView* alertView =  [GLAlertView sharedAlertView];
    
    alertView.style = style;
    alertView.animationView.style = style;
    [alertView.animationView isShowLayer:YES];
    [alertView.okButton setTitle:ok forState:UIControlStateNormal];
    [alertView.cancelButton setTitle:canle forState:UIControlStateNormal];
    alertView.titleLabel.text = title;
    alertView.detailLabel.text = detail;
    [alertView isShowControls:YES];
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

    [self setupAnimationView];
    [self setupControls];
}

- (void)setupAnimationView {
    self.animationView = [GLAnimationView new];
    self.animationView.center = self.center;
    [self addSubview:self.animationView];
}

- (void)setupControls {
    CGFloat x = self.animationView.left;
    CGFloat y = self.animationView.top;
    CGFloat height = self.animationView.height;
    CGFloat width = self.animationView.width;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x ,y + height / 2, width, titleLabelSize)];
    [self.titleLabel setFont:[UIFont systemFontOfSize:titleLabelSize]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    self.detailLabel  = [[UILabel alloc] initWithFrame:CGRectMake(x ,_titleLabel.bottom + 5, width, detailLabelSize)];
    self.detailLabel.textColor = [UIColor grayColor];
    [self.detailLabel setFont:[UIFont systemFontOfSize:detailLabelSize]];
    [self.detailLabel setTextAlignment:NSTextAlignmentCenter];
    
    CGFloat centerY = self.detailLabel.center.y + 20;
    
    self.okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.okButton.layer.cornerRadius = 5;
    self.okButton.titleLabel.font = [UIFont systemFontOfSize:buttonSize];
    self.okButton.center = CGPointMake(self.detailLabel.center.x + 50, centerY);
    self.okButton.bounds = CGRectMake(0, 0, width/2, height/4);
    
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.center = CGPointMake(self.detailLabel.center.x - 50, centerY);
    self.cancelButton.bounds = CGRectMake(0, 0, width/2, height/4);
    self.cancelButton.layer.cornerRadius = 5;
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:buttonSize];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.okButton];
    [self addSubview:self.cancelButton];
    
    [self.okButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)hide
{
    [self.animationView isShowLayer:NO];
    [self isShowControls:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.55 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        self.hidden = YES;
    });
}

- (void)isShowControls:(BOOL)show
{
    NSUInteger alpha = show ? 1 : 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.titleLabel.alpha = alpha;
        self.detailLabel.alpha = alpha;
        self.okButton.alpha = alpha;
        self.cancelButton.alpha = alpha;
    } ];
}


- (void)buttonClick:(UIButton *)sender
{
    [self hide];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
        //        else if(_clickBlock != nil)
        //        {
        //            self.clickBlock(sender.tag - TAG);
        //        }
    });
    
}


@end
