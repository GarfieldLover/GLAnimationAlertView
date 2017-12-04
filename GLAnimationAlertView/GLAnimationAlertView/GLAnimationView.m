//
//  GLAnimationView.m
//  GLAnimationAlertView
//
//  Created by ZK on 2017/11/29.
//  Copyright © 2017年 ZK. All rights reserved.
//

#import "GLAnimationView.h"
#import "UIView+Sizes.h"

@interface GLAnimationView ()

@property (nonatomic, strong) NSMutableArray* showLayerArray;


@end

@implementation GLAnimationView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
        [self setupLayers];
    }
    return self;
}

- (void)setupUI {
    self.bounds = CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.width/3.0f, [UIApplication sharedApplication].keyWindow.width/3.0f);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = self.width/10.0f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2.5f);
    self.layer.shadowOpacity = 0.25f;
    self.layer.shadowRadius = self.layer.cornerRadius;
}

- (void)setupLayers {
    self.showLayerArray = [NSMutableArray new];
    
    [self initSuccessLayer];
    [self initFailLayer];
    [self initWaringLayer];
    [self initLoadingLayer];
    //    [self initProgressLayer];
}

- (void)showAnimation:(BOOL)show {
    [self.layer removeAllAnimations];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];

    NSUInteger index = (NSUInteger)self.style;
    CAShapeLayer* layer = [self.showLayerArray objectAtIndex:index];
    
    switch (self.style) {
        case GLAlertViewStyleLoading:
        {
            if (show) {
                CABasicAnimation *animation = [CABasicAnimation animation];
                animation.keyPath = @"transform.rotation";
                animation.duration = 4.f;
                animation.fromValue = @(0.f);
                animation.toValue = @(2 * M_PI);
                animation.repeatCount = INFINITY;
                [layer addAnimation:animation forKey:@"mmmaterialdesignspinner.rotation"];
                
                CABasicAnimation *headAnimation = [CABasicAnimation animation];
                headAnimation.keyPath = @"strokeStart";
                headAnimation.duration = 1.f;
                headAnimation.fromValue = @(0.f);
                headAnimation.toValue = @(0.25f);
                headAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                
                CABasicAnimation *tailAnimation = [CABasicAnimation animation];
                tailAnimation.keyPath = @"strokeEnd";
                tailAnimation.duration = 1.f;
                tailAnimation.fromValue = @(0.f);
                tailAnimation.toValue = @(1.f);
                tailAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                
                CABasicAnimation *endHeadAnimation = [CABasicAnimation animation];
                endHeadAnimation.keyPath = @"strokeStart";
                endHeadAnimation.beginTime = 1.f;
                endHeadAnimation.duration = 0.5f;
                endHeadAnimation.fromValue = @(0.25f);
                endHeadAnimation.toValue = @(1.f);
                endHeadAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                
                CABasicAnimation *endTailAnimation = [CABasicAnimation animation];
                endTailAnimation.keyPath = @"strokeEnd";
                endTailAnimation.beginTime = 1.f;
                endTailAnimation.duration = 0.5f;
                endTailAnimation.fromValue = @(1.f);
                endTailAnimation.toValue = @(1.f);
                endTailAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                
                CAAnimationGroup *animations = [CAAnimationGroup animation];
                [animations setDuration:1.5f];
                [animations setAnimations:@[headAnimation, tailAnimation, endHeadAnimation, endTailAnimation]];
                animations.repeatCount = INFINITY;
                [layer addAnimation:animations forKey:@"mmmaterialdesignspinner.stroke"];
            }
            
        }
            break;
        case GLAlertViewStyleSuccess:
        case GLAlertViewStyleFail:
        case GLAlertViewStyleWaring:
            
        {
            NSNumber* from = show ? @0 : @1;
            NSNumber* to = show ? @1 : @0;
            
            CABasicAnimation *animation = [CABasicAnimation animation];
            animation.fromValue = from;
            animation.toValue = to;
            animation.duration = 0.8;
            [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
        }
            
        default:
            break;
    }
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    layer.frame = self.bounds;

    [self.layer addSublayer:layer];
}

- (CAShapeLayer *)layerConfig {
    CAShapeLayer* showLayer = [CAShapeLayer new];
    showLayer.anchorPoint = CGPointMake(0.5, 0.5);
    showLayer.fillColor = [UIColor clearColor].CGColor;
    showLayer.strokeColor = [UIColor clearColor].CGColor;
    showLayer.lineWidth = 3;
    return showLayer;
}

- (void)initSuccessLayer {
    CAShapeLayer* showLayer = [self layerConfig];
    
    CGPoint pathCenter = CGPointMake(self.width/2, self.width/4);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:pathCenter radius:self.width/6 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    path.lineCapStyle = kCGLineCapSquare;
    path.lineJoinStyle = kCGLineJoinBevel;
    pathCenter.x -= 3;
    
    CGFloat x = pathCenter.x * 0.88;
    CGFloat y = pathCenter.y * 1.13;
    //勾的起点
    [path moveToPoint:CGPointMake(x, y)];
    //勾的最底端
    CGPoint p1 = CGPointMake(pathCenter.x, pathCenter.y * 1.3);
    [path addLineToPoint:p1];
    //勾的最上端
    CGPoint p2 = CGPointMake(pathCenter.x * 1.2, pathCenter.y * 0.8);
    [path addLineToPoint:p2];
    //新建图层——绘制上面的圆圈和勾
    showLayer.strokeColor = [UIColor greenColor].CGColor;
    showLayer.path = path.CGPath;
    
    [self.showLayerArray addObject:showLayer];
}

- (void)initFailLayer {
    CAShapeLayer * showLayer = [self layerConfig];
    
    CGFloat x = self.width/2 - self.width/6;
    CGFloat y = self.width/6/2;
    
    //圆角矩形
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, self.width/6 * 2, self.width/6 * 2) cornerRadius:5];
    path.lineCapStyle = kCGLineCapSquare;
    path.lineJoinStyle = kCGLineJoinBevel;
    
    CGFloat space = self.width/6/2;
    //斜线1
    [path moveToPoint:CGPointMake(x + space, y + space)];
    CGPoint p1 = CGPointMake(x + self.width/6 * 2 - space, y + self.width/6 * 2 - space);
    [path addLineToPoint:p1];
    //斜线2
    [path moveToPoint:CGPointMake(x + self.width/6 * 2 - space , y + space)];
    CGPoint p2 = CGPointMake(x + space, y + self.width/6 * 2 - space);
    [path addLineToPoint:p2];
    
    //新建图层——绘制上述路径
    showLayer.strokeColor = [UIColor redColor].CGColor;
    showLayer.path = path.CGPath;
    
    [self.showLayerArray addObject:showLayer];
}

- (void)initWaringLayer {
    CAShapeLayer * showLayer = [self layerConfig];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapSquare;
    path.lineJoinStyle = kCGLineJoinBevel;
    
    //绘制三角形
    CGFloat x = self.width/2;
    CGFloat y = self.width/6/2;
    CGFloat y_buttom = self.width/2;
    //三角形起点（上方）
    [path moveToPoint:CGPointMake(x, y)];
    //左边
    CGPoint p1 = CGPointMake(x - self.width/6 , y_buttom*0.8);
    [path addLineToPoint:p1];
    //右边
    CGPoint p2 = CGPointMake(x + self.width/6 , y_buttom*0.8);
    [path addLineToPoint:p2];
    //关闭路径
    [path closePath];
    
    //绘制感叹号
    //绘制直线
    [path moveToPoint:CGPointMake(x, y_buttom*0.3)];
    CGPoint p4 = CGPointMake(x, y_buttom*0.6);
    [path addLineToPoint:p4];
    //绘制实心圆
    [path moveToPoint:CGPointMake(x, y_buttom*0.7)];
    [path addArcWithCenter:CGPointMake(x, y_buttom*0.7) radius:2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    //新建图层——绘制上述路径
    showLayer.strokeColor = [UIColor orangeColor].CGColor;
    showLayer.path = path.CGPath;
    
    [self.showLayerArray addObject:showLayer];
}

- (void)initLoadingLayer {
    CAShapeLayer* showLayer = [self layerConfig];
    CGFloat x = self.width/2;
    CGFloat y = self.width/2;
    CGFloat radius = self.width/2;

    
    CGPoint center = CGPointMake(x, y);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    path.lineCapStyle = kCGLineCapSquare;
    path.lineJoinStyle = kCGLineJoinBevel;
    
    showLayer.strokeColor = [UIColor greenColor].CGColor;
    showLayer.path = path.CGPath;
//    showLayer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [self.showLayerArray addObject:showLayer];
}

@end
