//
//  GLAnimationView.h
//  GLAnimationAlertView
//
//  Created by ZK on 2017/11/29.
//  Copyright © 2017年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLAnimationAlertView/GLAnimationAlertViewDefine.h"


@interface GLAnimationView : UIView

@property (nonatomic, assign) GLAlertViewStyle style;

- (void)isShowLayer:(BOOL)show;

@end
