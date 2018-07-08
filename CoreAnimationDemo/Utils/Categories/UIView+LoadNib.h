//
//  UIView+LoadNib.h
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/4.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 扩展视图直接加载xib功能。
 */
@interface UIView (LoadNib)

+ (UIView *)viewWithNibName:(NSString *)nibName;
+ (UIView *)viewWithNibName:(NSString *)nibName owner:(nullable id)owner;
+ (UIView *)viewWithNibName:(NSString *)nibName shouldCache:(BOOL)shouldCache;

/**
 * 根据xib的文件名创建UIView对象
 *
 * @param nibName xib文件名
 * @param owner 创建完成UIView的拥有者，参考[NSBundle-loadNibNamed:owner:options]方法，默认nil。
 * @param shouldCache 是否应该缓存，如果需要多次创建，可以缓存起来以优化性能，默认NO。
 */
+ (UIView *)viewWithNibName:(NSString *)nibName owner:(nullable id)owner shouldCache:(BOOL)shouldCache;

@end

NS_ASSUME_NONNULL_END
