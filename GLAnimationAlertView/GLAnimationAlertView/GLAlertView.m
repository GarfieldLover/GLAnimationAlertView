//
//  GLAlertView.m
//  GLAnimationAlertView
//
//  Created by ZK on 2017/11/29.
//  Copyright © 2017年 ZK. All rights reserved.
//

#import "GLAlertView.h"
#import "GLAnimationView.h"

@interface GLAlertView ()

@property (nonatomic, strong) GLAnimationView* animationView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* detailLabel;
@property (nonatomic, strong) UILabel* okButton;
@property (nonatomic, strong) UIButton* cancelButton;

@end

@implementation GLAlertView


+ (instancetype)showAlertViewWithStyle:(WKAlertViewStyle)style
                            noticStyle:(WKAlertViewNoticStyle)noticStyle
                                 title:(NSString *)title
                                detail:(NSString *)detail
                      canleButtonTitle:(NSString *)canle
                         okButtonTitle:(NSString *)ok
                             callBlock:(callBack)callBack{
    GLAlertView* alertView =  [GLAlertView sharedAlertView];
    
    alertView.hidden = YES;
    temp.style = style;
    [alertView isShowLayer:YES];
    [alertView addButtonTitleWithCancle:canle OK:ok];
    [alertView addTitle:title detail:detail];
    [alertView isShowControls:YES];
    [alertView setClickBlock:nil];//释放掉之前的Block
    [alertView setClickBlock:callBack];
    
    return alertView;
}

//单例
+ (instancetype)sharedAlertView {
    static dispatch_once_t onceToken;
    static WKAlertView* alertView;
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
    self.frame = (CGRect) {{0.f,0.f}, [[UIScreen mainScreen] bounds].size};
    self.alpha = 1;
    [self setBackgroundColor:[UIColor clearColor]];
    self.hidden = NO;//不隐藏
    _showLayerArray = [NSMutableArray new];
    
    [self setupAnimationView];
    [self setupControls];
}

- (void)setupAnimationView {
    _logoView                     = [UIView new];
    _logoView.center              = self.center;
    _logoView.bounds              = CGRectMake(0, 0, Logo_View_Size, Logo_View_Size);
    _logoView.backgroundColor     = [UIColor whiteColor];
    _logoView.layer.cornerRadius  = 10;
    _logoView.layer.shadowColor   = [UIColor blackColor].CGColor;
    _logoView.layer.shadowOffset  = CGSizeMake(0, 5);
    _logoView.layer.shadowOpacity = 0.3f;
    _logoView.layer.shadowRadius  = 10.0f;
    [self addSubview:_logoView];
}

- (void)setupControls {
    CGFloat x = _logoView.frame.origin.x;
    CGFloat y = _logoView.frame.origin.y;
    CGFloat height = _logoView.frame.size.height;
    CGFloat width = _logoView.frame.size.width;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x ,y + height / 2, width, Title_Font)];
    [_titleLabel setFont:[UIFont systemFontOfSize:Title_Font]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    _detailLabel  = [[UILabel alloc] initWithFrame:CGRectMake(x ,_titleLabel.bottomS + 5, width, Detial_Font )];
    _detailLabel.textColor = [UIColor grayColor];
    [_detailLabel setFont:[UIFont systemFontOfSize:Detial_Font]];
    [_detailLabel setTextAlignment:NSTextAlignmentCenter];
    
    CGFloat centerY = _detailLabel.center.y + 20;
    
    _OkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _OkButton.layer.cornerRadius = 5;
    _OkButton.titleLabel.font = [UIFont systemFontOfSize:Button_Font];
    _OkButton.center = CGPointMake(_detailLabel.center.x + 50, centerY);
    _OkButton.bounds = CGRectMake(0, 0, Button_Size_Width, Button_Size_Height);
    _OkButton.backgroundColor = OKBUTTON_BGCOLOR;
    
    
    _canleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _canleButton.center = CGPointMake(_detailLabel.center.x - 50, centerY);
    _canleButton.bounds = CGRectMake(0, 0, Button_Size_Width, Button_Size_Height);
    _canleButton.backgroundColor = CANCELBUTTON_BGCOLOR;
    _canleButton.layer.cornerRadius = 5;
    _canleButton.titleLabel.font = [UIFont systemFontOfSize:Button_Font];
    
    
    [self addSubview:_titleLabel];
    [self addSubview:_detailLabel];
    [self addSubview:_OkButton];
    [self addSubview:_canleButton];
    _titleLabel.alpha = 0;
    _detailLabel.alpha = 0;
    _OkButton.alpha = 0;
    _canleButton.alpha = 0;
    
    _canleButton.hidden = YES;
    _OkButton.hidden = YES;
    
    _OkButton.tag = TAG;
    _canleButton.tag = TAG + 1;
    
    [_OkButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_canleButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)show
{
    [KEYWINDOW addSubview:self];
    self.hidden = NO;
}

- (void)hide
{
    [self isShowLayer:NO];
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
        _titleLabel.alpha = alpha;
        _detailLabel.alpha = alpha;
        _OkButton.alpha = alpha;
        _canleButton.alpha = alpha;
        _logoView.alpha = alpha;
    } ];
}

- (void)isShowLayer:(BOOL)show
{
    
    //strokeEnd
    //通过对from，to赋值，可让贝塞尔动画从终点至起点，或起点至终点
    NSNumber * from = show ? @0 : @1;
    NSNumber * to = show ? @1 : @0;
    
    [_logoView.layer removeAllAnimations];
    [_logoView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = from;
    animation.toValue = to;
    animation.duration = 0.5;
    NSUInteger index = (NSUInteger)self.style;
    CAShapeLayer * layer = [_showLayerArray objectAtIndex:(index > 0 ? index - 1 :index)];
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [_logoView.layer addSublayer:layer];
}


- (void)buttonClick:(UIButton *)sender
{
    [self hide];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
        if (_WKAlertViewDelegate && [_WKAlertViewDelegate respondsToSelector:@selector(alertViewClick:)] ) {
            [_WKAlertViewDelegate alertViewClick:sender.tag - TAG ];
        }
        else if(_clickBlock != nil)
        {
            self.clickBlock(sender.tag - TAG);
        }
    });
    
}


@end
