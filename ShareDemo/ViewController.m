//
//  ViewController.m
//  ShareDemo
//
//  Created by ss on 2016/10/25.
//  Copyright © 2016年 ss. All rights reserved.
//

#import "ViewController.h"
#import "ShareInfoManager.h"
#import "ShareListModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 50, 50)];
    // 监听按钮点击
    [btn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blackColor];
    // 添加按钮
    [self.view addSubview:btn];
}




- (void)add
{
    ShareInfoManager * manager = [ShareInfoManager shareInstance];
    NSDictionary * dict = @{@"url":@"1",
                            @"title":@"2",
                            @"shareImg":@"3r",
                            @"content":@"只为男士独家定制美容计划，源于我们热爱高品质男性生活。了解更多请戳……",
                           };
    manager.shareModel =  [ShareListModel ShareWithDict:dict];
    manager.shareVC = self;
    [manager shareBtnDelegate];
}
@end
