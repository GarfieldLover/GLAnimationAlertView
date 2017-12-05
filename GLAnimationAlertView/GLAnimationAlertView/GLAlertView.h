//
//  GLAlertView.h
//  GLAnimationAlertView
//
//  Created by ZK on 2017/11/29.
//  Copyright © 2017年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLAnimationAlertView/GLAnimationAlertViewDefine.h"


@interface GLAlertView : UIView

+ (instancetype)showAlertViewWithStyle:(GLAlertViewStyle)style
                                 title:(NSString *)title
                                detail:(NSString *)detail
                      canleButtonTitle:(NSString *)canle
                         okButtonTitle:(NSString *)ok;

+ (void)setProgress:(CGFloat)progress;

@end
