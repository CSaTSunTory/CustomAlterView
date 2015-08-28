//
//  ViewController.m
//  CustomAlterVIew
//
//  Created by lxb on 15/8/28.
//  Copyright (c) 2015年 youyuan. All rights reserved.
//

#import "ViewController.h"
#import "CustomIOSAlertView.h"
@interface ViewController ()<CustomIOSAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CustomAlterVIewAction:(UIButton *)sender {
    CustomIOSAlertView *alter  =  [[CustomIOSAlertView alloc]init];
    alter.titleColor = [UIColor redColor];
    alter.buttonTitles = @[@"取消",@"确定"];
    alter.message = @"确定要提交作业吗？";
    alter.delegate = self;
    [alter show];
}

- (void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView close];

}
@end
