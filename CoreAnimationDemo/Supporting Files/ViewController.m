//
//  ViewController.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/6/22.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "ViewController.h"

#import "UIViewController+Convenience.h"
#import "Section2ViewController.h"
#import "Section3ViewController.h"
#import "Section4ViewController.h"
#import "Section5ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewControllerArray addObject:[Section2ViewController viewControllerInitByXibWithTitle:@"寄宿图"]];
    [self.viewControllerArray addObject:[Section3ViewController viewControllerInitByXibWithTitle:@"图层几何学"]];
    [self.viewControllerArray addObject:[Section4ViewController viewControllerInitByXibWithTitle:@"视觉效果"]];
    [self.viewControllerArray addObject:[Section5ViewController viewControllerWithTitle:@"变换"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
