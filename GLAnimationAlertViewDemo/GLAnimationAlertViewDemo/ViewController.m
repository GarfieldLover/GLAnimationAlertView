//
//  ViewController.m
//  GLAnimationAlertViewDemo
//
//  Created by ZK on 2017/11/27.
//  Copyright © 2017年 ZK. All rights reserved.
//

#import "ViewController.h"
#import "GLAnimationAlertView/GLAnimationAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showSuccess:(id)sender {
    [GLAlertView showAlertViewWithStyle:GLAlertViewStyleSuccess title:@"支付成功" detail:@"请查看支付详情" canleButtonTitle:@"取消" okButtonTitle:@"确定"];
}

- (IBAction)showFail:(id)sender {
    [GLAlertView showAlertViewWithStyle:GLAlertViewStyleFail title:@"支付失败" detail:@"请查看支付详情" canleButtonTitle:@"取消" okButtonTitle:@"确定"];
}

- (IBAction)showWaring:(id)sender {
    [GLAlertView showAlertViewWithStyle:GLAlertViewStyleWaring title:@"支付错误" detail:@"请查看支付详情" canleButtonTitle:@"取消" okButtonTitle:@"确定"];
}

- (IBAction)showLoading:(id)sender {
    [GLAlertView showAlertViewWithStyle:GLAlertViewStyleLoading title:@"支付错误" detail:@"请查看支付详情" canleButtonTitle:@"取消" okButtonTitle:@"确定"];
}
- (IBAction)showProgress:(id)sender {
    [GLAlertView showAlertViewWithStyle:GLAlertViewStyleProgress title:@"支付错误" detail:@"请查看支付详情" canleButtonTitle:@"取消" okButtonTitle:@"确定"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
