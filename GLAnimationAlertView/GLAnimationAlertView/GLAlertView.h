//
//  GLAlertView.h
//  GLAnimationAlertView
//
//  Created by ZK on 2017/11/29.
//  Copyright © 2017年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 状态类型

 - GLAlertViewStyleSuccess: 成功
 - GLAlertViewStyleFail: 失败
 - GLAlertViewStyleWaring: 警告
 */
typedef NS_ENUM(NSInteger, GLAlertViewStyle) {
    GLAlertViewStyleSuccess,
    GLAlertViewStyleFail,
    GLAlertViewStyleWaring
};


@interface GLAlertView : UIView

+ (instancetype)showAlertViewWithStyle:(WKAlertViewStyle)style
                                 title:(NSString *)title
                                detail:(NSString *)detail
                      canleButtonTitle:(NSString *)canle
                         okButtonTitle:(NSString *)ok
                             callBlock:(callBack)callBack;

@end
