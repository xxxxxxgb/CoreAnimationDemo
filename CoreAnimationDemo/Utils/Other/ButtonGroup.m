//
//  ButtonGroup.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/6/23.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "ButtonGroup.h"

#define BLOCK_CALLBACK(button, index) \
do { \
    if (self.buttonStatusDidChangeBlock) { \
        self.buttonStatusDidChangeBlock(button, index); \
    } \
} while(0)

@interface ButtonGroup()
@property (readwrite, nonatomic, assign) ButtonGroupType groupType;
@property (copy, nonatomic) ButtonStatusDidChangeBlock buttonStatusDidChangeBlock;
// 因为UI操作都是在主线程进行的，所以不考虑多线程问题。
@property (strong, nonatomic) NSMutableOrderedSet<UIButton *> *buttons;
@property (readwrite, nonatomic, strong) NSMutableIndexSet *mutableCurrentSelectedIndexs;
@end

@implementation ButtonGroup

# pragma mark - API

- (instancetype) init {
    NSAssert(false, @"需使用-initWithExclusive:buttonStatusDidChangeBlock:初始化方法。");
    return nil;
}

- (instancetype)initWithGroupType:(ButtonGroupType)groupType buttonStatusDidChangeBlock:(ButtonStatusDidChangeBlock)block {
    if ((self = [super init])) {
        self.groupType = groupType;
        self.mutableCurrentSelectedIndexs = [NSMutableIndexSet indexSetWithIndex:0];
        self.buttonStatusDidChangeBlock = block;
        self.buttons = [NSMutableOrderedSet orderedSet];
    }
    return self;
}

+ (ButtonGroup *)buttonGroupWithGroupType:(ButtonGroupType)groupType buttonStatusDidChangeBlock:(ButtonStatusDidChangeBlock)block {
    return [[[self class] alloc] initWithGroupType:groupType buttonStatusDidChangeBlock:block];
}

- (void)addButton:(UIButton *)button {
    [button addTarget:self action:@selector(_buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons addObject:button];
}

- (void)insertButton:(UIButton *)button atIndex:(NSInteger)index {
    [button addTarget:self action:@selector(_buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons insertObject:button atIndex:index];
}

- (NSInteger)removeButton:(UIButton *)button {
    NSInteger index = [self.buttons indexOfObject:button];
    [button removeTarget:self action:@selector(_buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons removeObject:button];
    return index;
}

- (UIButton *)removeButtonWithIndex:(NSInteger)index {
    if (index > self.buttons.count - 1) return nil;
    UIButton *button = self.buttons[index];
    [button removeTarget:self action:@selector(_buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons removeObjectAtIndex:index];
    return button;
}

- (NSIndexSet *)currentSelectedIndexs {
    return [self.mutableCurrentSelectedIndexs copy];
}

#pragma mark - Privacy

- (void)_buttonClicked:(UIButton *)button {
    NSInteger index = [self.buttons indexOfObject:button];
    if (self.groupType == ButtonGroupTypeCheckBox) {
        button.selected = !button.isSelected;
        button.selected ? [self.mutableCurrentSelectedIndexs addIndex:index] : [self.mutableCurrentSelectedIndexs removeIndex:index];
        BLOCK_CALLBACK(button, index);
    } else {
        if (button.isSelected && self.groupType == ButtonGroupTypeRadioEnableNoSeleted) {
            button.selected = NO;
            [self.mutableCurrentSelectedIndexs removeIndex:index];
            BLOCK_CALLBACK(button, index);
        } else if (!button.isSelected) {
            for (NSInteger i = 0; i < self.buttons.count; i++) {
                UIButton *tempButton = [self.buttons objectAtIndex:i];
                if (tempButton.isSelected) {
                    tempButton.selected = NO;
                    [self.mutableCurrentSelectedIndexs removeIndex:i];
                    BLOCK_CALLBACK(tempButton, i);
                    break;
                }
            }
            button.selected = YES;
            [self.mutableCurrentSelectedIndexs addIndex:index];
            BLOCK_CALLBACK(button, index);
        }
    }
}

@end

