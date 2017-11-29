//
//  GLAnimationView.m
//  GLAnimationAlertView
//
//  Created by ZK on 2017/11/29.
//  Copyright © 2017年 ZK. All rights reserved.
//

#import "GLAnimationView.h"

@implementation GLAnimationView

- (void)layerInit
{
    
    [_showLayerArray removeAllObjects];
    switch (self.noticStyle) {
            
        case WKAlertViewNoticStyleFace:
        {
            [self initPathForRightShapeLayerWithFace];
            [self initPathForWrongShapeLayerWithFace];
            [self initPathForWaringShapeLayerWithFace];
            break;
        }
        default:
        case WKAlertViewNoticStyleClassic: {
            [self initPathForRightShapeLayer];
            [self initPathForWrongShapeLayer];
            [self initPathForWaringShapeLayer];
            break;
        }
    }
    
}
- (CAShapeLayer *)layerConfig
{
    CAShapeLayer * showLayer = [CAShapeLayer new];
    showLayer.fillColor = [UIColor clearColor].CGColor;
    showLayer.strokeColor = [UIColor clearColor].CGColor;
    showLayer.lineWidth = _noticStyle == WKAlertViewNoticStyleClassic ? CLASSICLLINEWIDTH : FACELINEWIDTH;
    return showLayer;
}

- (void)initPathForRightShapeLayer
{
    
    CAShapeLayer * showLayer = [self layerConfig];
    
    
    CGPoint pathCenter = CGPointMake(_logoView.frame.size.width/2, _logoView.frame.size.height/4);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:pathCenter radius:Logo_Size startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
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

- (void)initPathForWrongShapeLayer
{
    
    CAShapeLayer * showLayer = [self layerConfig];
    
    
    CGFloat x = _logoView.frame.size.width / 2 - Logo_Size;
    CGFloat y = Logo_Size / 2.0;
    
    //圆角矩形
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, Logo_Size * 2, Logo_Size * 2) cornerRadius:5];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    CGFloat space = Logo_Size / 2;
    //斜线1
    [path moveToPoint:CGPointMake(x + space, y + space)];
    CGPoint p1 = CGPointMake(x + Logo_Size * 2 - space, y + Logo_Size * 2 - space);
    [path addLineToPoint:p1];
    //斜线2
    [path moveToPoint:CGPointMake(x + Logo_Size * 2 - space , y + space)];
    CGPoint p2 = CGPointMake(x + space, y + Logo_Size * 2 - space);
    [path addLineToPoint:p2];
    
    //新建图层——绘制上述路径
    showLayer.strokeColor = [UIColor redColor].CGColor;
    showLayer.path = path.CGPath;
    [_showLayerArray addObject:showLayer];
    
}

- (void)initPathForWaringShapeLayer
{
    CAShapeLayer * showLayer = [self layerConfig];
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    //绘制三角形
    CGFloat x = _logoView.frame.size.width/2;
    CGFloat y = Logo_Size / 2.0;
    //三角形起点（上方）
    [path moveToPoint:CGPointMake(x, y)];
    //左边
    CGPoint p1 = CGPointMake(x - Logo_Size , x * 0.8);
    [path addLineToPoint:p1];
    //右边
    CGPoint p2 = CGPointMake(x + Logo_Size , x * 0.8);
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
er

@end
