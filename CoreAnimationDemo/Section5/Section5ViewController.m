//
//  Section5ViewController.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/10.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "Section5ViewController.h"
#import "UIViewController+Convenience.h"
#import "AffineTransformViewController.h"
#import "Transform3DViewController.h"
#import "CubeViewController.h"

@interface Section5ViewController ()

@end

@implementation Section5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewControllerArray addObject:[AffineTransformViewController viewControllerInitByXibWithTitle:@"仿射矩阵"]];
    [self.viewControllerArray addObject:[Transform3DViewController viewControllerInitByXibWithTitle:@"3D矩阵"]];
    [self.viewControllerArray addObject:[CubeViewController viewControllerInitByXibWithTitle:@"固态对象"]];
}

@end
