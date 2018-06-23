//
//  BaseViewController.h
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/6/22.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (instancetype)initWithTitle:(NSString *)title;

+ (BaseViewController *)viewControllerWithTitle:(NSString *)title;

@end
