//
//  BaseViewController.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/6/22.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (instancetype)initWithTitle:(NSString *)title {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    if (self) {
        self.title = title;
    }
    return self;
}

+ (BaseViewController *)viewControllerWithTitle:(NSString *)title {
    return [[[self class] alloc] initWithTitle:title];
}

@end
