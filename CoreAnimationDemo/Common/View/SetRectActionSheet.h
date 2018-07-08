//
//  SetRectActionSheet.h
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/6/26.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBActionSheet.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SetRectActionSheetBlock)(CGRect rect);

@interface SetRectActionSheet : TBActionSheet

- (instancetype)initWithMaxPoint:(CGPoint)maxPoint
                  completedBlock:(SetRectActionSheetBlock)completedBlock;
- (instancetype)initWithMaxSize:(CGSize)maxSize
                 completedBlock:(SetRectActionSheetBlock)completedBlock;
- (instancetype)initWithMaxRect:(CGRect)maxRect
                 completedBlock:(SetRectActionSheetBlock)completedBlock;

- (void)show __attribute__((unavailable("使用-showWithPoint:、-showWithSize:或者-showWithRect:")));
- (void)showWithPoint:(CGPoint)point;
- (void)showWithSize:(CGSize)size;
- (void)showWithRect:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
