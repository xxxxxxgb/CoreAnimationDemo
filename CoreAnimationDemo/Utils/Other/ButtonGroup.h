//
//  ButtonGroup.h
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/6/23.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ButtonGroupType) {
    ButtonGroupTypeRadio                    = 0,
    ButtonGroupTypeRadioEnableNoSeleted     = 1,
    ButtonGroupTypeCheckBox                 = 2,
};

/** 在单选情况下只有对象的状态发生改变才进行回调，可以通过UIButton的isSelected属性来判断按钮的选择情况 */
typedef void (^ButtonStatusDidChangeBlock)(UIButton *button, NSInteger index);

/**
 * 处理单选框或者复选框的逻辑部分。
 */
@interface ButtonGroup : NSObject
/** 按钮间是否互斥（单选还是多选） */
@property (readonly, assign, nonatomic) ButtonGroupType groupType;
/** 当前选中按钮的下标 */
@property (readonly, strong, nonatomic) NSIndexSet *currentSelectedIndexs;
/** 多选时，最多能选中的按钮数量。（待扩展） */
@property (assign, nonatomic) NSInteger maxSelectedButton;

- (id) init __attribute__((unavailable("需使用-initWithExclusive:buttonStatusDidChangeBlock:初始化方法。")));
- (instancetype)initWithGroupType:(ButtonGroupType)groupType buttonStatusDidChangeBlock:(nullable ButtonStatusDidChangeBlock)block;
+ (ButtonGroup *)buttonGroupWithGroupType:(ButtonGroupType)groupType buttonStatusDidChangeBlock:(nullable ButtonStatusDidChangeBlock)block;

- (void)addButton:(UIButton *)button;
- (void)insertButton:(UIButton *)button atIndex:(NSInteger)index;
- (NSInteger)removeButton:(UIButton *)button;
- (UIButton *)removeButtonWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
