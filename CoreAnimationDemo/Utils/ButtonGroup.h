//
//  ButtonGroup.h
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/6/23.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 在单选情况下只有对象的状态发生改变才进行回调，可以通过UIButton的isSelected属性来判断按钮的选择情况 */
typedef void (^ButtonSelectedBlock)(UIButton *button, NSInteger index);

@interface ButtonGroup : NSObject
@property (readonly, assign, nonatomic, getter=isExclusive) BOOL exclusive;
@property (readonly, strong, nonatomic) NSIndexSet *currentSelectedIndexs;

- (id) init __attribute__((unavailable("需使用-initWithExclusive:transitionBlock:初始化方法。")));
- (instancetype)initWithExclusive:(BOOL)exclusive buttonSelectedBlock:(ButtonSelectedBlock)block;
+ (ButtonGroup *)buttonGroupWithExclusive:(BOOL)exclusive buttonSelectedBlock:(ButtonSelectedBlock)block;

- (void)addButton:(UIButton *)button;
- (void)insertButton:(UIButton *)button atIndex:(NSInteger)index;
- (NSInteger)removeButton:(UIButton *)button;
- (UIButton *)removeButtonWithIndex:(NSInteger)index;

@end
