//
//  SetColorActionSheet.h
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/5.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "TBActionSheet.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SetColorActionSheetBlock)(UIColor *color);

@interface SetColorActionSheet : TBActionSheet

- (instancetype)initWithCompletedBlock:(SetColorActionSheetBlock)completedBlock;

- (void)show __attribute__((unavailable("需使用-showWithColor:。")));
- (void)showWithColor:(nullable UIColor *)color;
@end

NS_ASSUME_NONNULL_END
