//
//  UIViewController+Convenience.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/10.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "UIViewController+Convenience.h"

@implementation UIViewController (Convenience)

+ (UIViewController *)viewControllerWithTitle:(NSString *)title {
    UIViewController *viewController = [[self alloc] init];
    viewController.title = title;
    return viewController;
}

+ (UIViewController *)viewControllerInitByXibWithTitle:(NSString *)title {
    UIViewController *viewController = [[self alloc] initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    viewController.title = title;
    return viewController;
}

@end
