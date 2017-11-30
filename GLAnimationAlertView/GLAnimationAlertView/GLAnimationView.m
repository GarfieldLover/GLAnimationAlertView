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
        self.bounds = CGRectMake(0, 0, 100, 100);
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 5);
        self.layer.shadowOpacity = 0.3f;
        self.layer.shadowRadius = 10.0f;
        
        [self layerInit];
    }
    return self;
}

- (void)isShowLayer:(BOOL)show
{
    
        //strokeEnd
        //通过对from，to赋值，可让贝塞尔动画从终点至起点，或起点至终点
        NSNumber * from = show ? @0 : @1;
        NSNumber * to = show ? @1 : @0;
    
        [self.layer removeAllAnimations];
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
        animation.fromValue = from;
        animation.toValue = to;
        animation.duration = 0.5;
        NSUInteger index = (NSUInteger)self.style;
        CAShapeLayer * layer = [_showLayerArray objectAtIndex:index];
        [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
        [self.layer addSublayer:layer];
}


- (void)layerInit {
    self.showLayerArray = [NSMutableArray new];
    
    [self.showLayerArray removeAllObjects];
    
    [self initPathForRightShapeLayer];
    [self initPathForWrongShapeLayer];
    [self initPathForWaringShapeLayer];
}

- (CAShapeLayer *)layerConfig {
    CAShapeLayer * showLayer = [CAShapeLayer new];
    showLayer.fillColor = [UIColor clearColor].CGColor;
    showLayer.strokeColor = [UIColor clearColor].CGColor;
    showLayer.lineWidth = 3;
    return showLayer;
}

- (void)initPathForRightShapeLayer {
    
    CAShapeLayer * showLayer = [self layerConfig];
    
    CGPoint pathCenter = CGPointMake(self.width/2, self.height/4);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:pathCenter radius:self.height/6 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    pathCenter.x -= 3;
    
    CGFloat x = pathCenter.x * 0.88;
    CGFloat y = pathCenter.y * 1.13;
    //勾的起点
    [path moveToPoint:CGPointMake(x, y)];
    //勾的最底端
    CGPoint p1 = CGPointMake(pathCenter.x, pathCenter.y * 1.3);
    [path addLineToPoint:p1];
    //勾的最上端
    CGPoint p2 = CGPointMake(pathCenter.x * 1.2,pathCenter.y * 0.8);
    [path addLineToPoint:p2];
    //新建图层——绘制上面的圆圈和勾
    showLayer.strokeColor = [UIColor greenColor].CGColor;
    showLayer.path = path.CGPath;
    
    [_showLayerArray addObject:showLayer];
}

- (void)initPathForWrongShapeLayer {
    
    CAShapeLayer * showLayer = [self layerConfig];
    
    
    CGFloat x = self.width / 2 - self.height/6;
    CGFloat y = self.height/6 / 2.0;
    
    //圆角矩形
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, self.height/6 * 2, self.height/6 * 2) cornerRadius:5];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    CGFloat space = self.height/6 / 2;
    //斜线1
    [path moveToPoint:CGPointMake(x + space, y + space)];
    CGPoint p1 = CGPointMake(x + self.height/6 * 2 - space, y + self.height/6 * 2 - space);
    [path addLineToPoint:p1];
    //斜线2
    [path moveToPoint:CGPointMake(x + self.height/6 * 2 - space , y + space)];
    CGPoint p2 = CGPointMake(x + space, y + self.height/6 * 2 - space);
    [path addLineToPoint:p2];
    
    //新建图层——绘制上述路径
    showLayer.strokeColor = [UIColor redColor].CGColor;
    showLayer.path = path.CGPath;
    [_showLayerArray addObject:showLayer];
    
}

- (void)initPathForWaringShapeLayer {
    CAShapeLayer * showLayer = [self layerConfig];
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    //绘制三角形
    CGFloat x = self.width/2;
    CGFloat y = self.height/6 / 2.0;
    //三角形起点（上方）
    [path moveToPoint:CGPointMake(x, y)];
    //左边
    CGPoint p1 = CGPointMake(x - self.height/6 , x * 0.8);
    [path addLineToPoint:p1];
    //右边
    CGPoint p2 = CGPointMake(x + self.height/6 , x * 0.8);
    [path addLineToPoint:p2];
    //关闭路径
    [path closePath];
    
    //绘制感叹号
    //绘制直线
    [path moveToPoint:CGPointMake(x, x * 0.3)];
    CGPoint p4 = CGPointMake(x, x * 0.6);
    [path addLineToPoint:p4];
    //绘制实心圆
    [path moveToPoint:CGPointMake(x, x * 0.7)];
    [path addArcWithCenter:CGPointMake(x, x * 0.7) radius:2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    //新建图层——绘制上述路径
    showLayer.strokeColor = [UIColor orangeColor].CGColor;
    showLayer.path = path.CGPath;
    [_showLayerArray addObject:showLayer];
}

@end
