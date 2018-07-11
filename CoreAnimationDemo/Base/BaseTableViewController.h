//
//  BaseTableViewController.h
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/10.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : UITableViewController

/** 要显示的视图控制器数组 */
@property (strong, nonatomic) NSMutableArray<UIViewController *> *viewControllerArray;

@end

NS_ASSUME_NONNULL_END
