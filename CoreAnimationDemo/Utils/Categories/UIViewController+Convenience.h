//
//  UIViewController+Convenience.h
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/10.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Convenience)

/** 创建UIViewController并初始化其title */
+ (UIViewController *)viewControllerWithTitle:(NSString *)title;

/** 通过xib文件创建UIViewController并初始化其title，xib文件名与其类名相同 */
+ (UIViewController *)viewControllerInitByXibWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
