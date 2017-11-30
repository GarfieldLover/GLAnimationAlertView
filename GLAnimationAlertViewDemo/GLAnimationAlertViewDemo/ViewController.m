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

- (void)viewDidAppear:(BOOL)animated {
    [GLAlertView showAlertViewWithStyle:GLAlertViewStyleSuccess title:@"标题标题标题标题标题标题标题标题" detail:@"详情详情详情详情详情详情详情详情详情详情详情详情" canleButtonTitle:@"can" okButtonTitle:@"ok"];
    
    //3种状态
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
