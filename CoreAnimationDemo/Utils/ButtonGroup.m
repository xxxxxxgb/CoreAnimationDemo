//
//  ButtonGroup.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/6/23.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "ButtonGroup.h"

@interface ButtonGroup()
@property (copy, nonatomic) ButtonSelectedBlock buttonSelectedBlock;
/** 因为UI操作都是在主线程进行的，所以不考虑多线程问题。 */
@property (strong, nonatomic) NSMutableOrderedSet<UIButton *> *buttons;
@end

@implementation ButtonGroup {
    NSMutableIndexSet *_currentSelectedIndexs;
}

- (instancetype) init {
    NSAssert(false, @"需使用-initWithExclusive:transitionBlock:初始化方法。");
    return nil;
}

- (instancetype)initWithExclusive:(BOOL)exclusive buttonSelectedBlock:(ButtonSelectedBlock)block {
    if ((self = [super init])) {
        _exclusive = exclusive;
        _currentSelectedIndexs = [NSMutableIndexSet indexSetWithIndex:0];
        self.buttonSelectedBlock = block;
        self.buttons = [NSMutableOrderedSet orderedSet];
    }
    return self;
}

+ (ButtonGroup *)buttonGroupWithExclusive:(BOOL)exclusive buttonSelectedBlock:(ButtonSelectedBlock)block {
    return [[[self class] alloc] initWithExclusive:exclusive buttonSelectedBlock:block];
}

- (void)addButton:(UIButton *)button {
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons addObject:button];
}

- (void)insertButton:(UIButton *)button atIndex:(NSInteger)index {
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons insertObject:button atIndex:index];
}

- (NSInteger)removeButton:(UIButton *)button {
    NSInteger index = [self.buttons indexOfObject:button];
    [button removeTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons removeObject:button];
    return index;
}

- (UIButton *)removeButtonWithIndex:(NSInteger)index {
    if (index > self.buttons.count - 1) return nil;
    UIButton *button = self.buttons[index];
    [button removeTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons removeObjectAtIndex:index];
    return button;
}

- (void)buttonClicked:(UIButton *)button {
    NSInteger index = [self.buttons indexOfObject:button];
    if (self.isExclusive) {
        if (!button.isSelected) {
            for (NSInteger i = 0; i < self.buttons.count; i++) {
                UIButton *tempButton = [self.buttons objectAtIndex:i];
                if (tempButton.isSelected) {
                    tempButton.selected = NO;
                    [_currentSelectedIndexs removeIndex:i];
                    self.buttonSelectedBlock(tempButton, i);
                    break;
                }
            }
            button.selected = YES;
            [_currentSelectedIndexs addIndex:index];
            self.buttonSelectedBlock(button, index);
        }
    } else {
        button.selected = !button.isSelected;
        button.selected ? [_currentSelectedIndexs addIndex:index] : [_currentSelectedIndexs removeIndex:index];
        self.buttonSelectedBlock(button, index);
    }
}

- (NSIndexSet *)currentSelectedIndexs {
    return [_currentSelectedIndexs copy];
}

@end

