//
//  SetColorActionSheet.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/5.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "SetColorActionSheet.h"
#import "UIView+LoadNib.h"

@interface SetColorActionSheet() <TBActionSheetDelegate>
@property (copy, nonatomic) SetColorActionSheetBlock completedBlock;

@property (weak, nonatomic) UISlider *redSlider;
@property (weak, nonatomic) UISlider *greenSlider;
@property (weak, nonatomic) UISlider *blueSlider;
@property (weak, nonatomic) UISlider *alphaSlider;

@property (weak, nonatomic) UIView *displayView;
@end

@implementation SetColorActionSheet

#pragma mark - API

- (instancetype)initWithCompletedBlock:(SetColorActionSheetBlock)completedBlock {
    if (completedBlock == nil) {
        NSLog(@"[SetColorActionSheet -initWithCompletedBlock:]方法completedBlock参数不能为空");
        return nil;
    }
    
    self = [super initWithTitle:@"设置颜色" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:nil];
    if (self) {
        self.completedBlock = completedBlock;
        __weak __typeof(self) weakSelf = self;
        self.delegate = weakSelf;
        
        UIView *setColorView = [UIView viewWithNibName:@"SetColorView" shouldCache:YES];
        self.redSlider = setColorView.subviews[0];
        self.greenSlider = setColorView.subviews[1];
        self.blueSlider = setColorView.subviews[2];
        self.alphaSlider = setColorView.subviews[3];
        self.displayView = setColorView.subviews[4];
        self.customView = setColorView;
        
        [self.redSlider addTarget:self action:@selector(_updateDisplay) forControlEvents:UIControlEventValueChanged];
        [self.greenSlider addTarget:self action:@selector(_updateDisplay) forControlEvents:UIControlEventValueChanged];
        [self.blueSlider addTarget:self action:@selector(_updateDisplay) forControlEvents:UIControlEventValueChanged];
        [self.alphaSlider addTarget:self action:@selector(_updateDisplay) forControlEvents:UIControlEventValueChanged];
        
        [self addButtonWithTitle:@"确定" style:TBActionButtonStyleDefault handler:^(TBActionButton * _Nonnull button) {
            if (weakSelf.completedBlock) {
                UIColor *finalColor = [UIColor colorWithRed:weakSelf.redSlider.value green:weakSelf.greenSlider.value blue:weakSelf.blueSlider.value alpha:weakSelf.alphaSlider.value];
                weakSelf.completedBlock(finalColor);
            }
        }];
    }
    
    return self;
}

- (void)show {
    NSAssert(false, @"[SetColorActionSheet -show]方法弃用");
}

- (void)showWithColor:(UIColor *)color {
    if (color) {
        CGFloat r=0,g=0,b=0,a=0;
        if(![color getRed:&r green:&g blue:&b alpha:&a]) {
            const CGFloat *components = CGColorGetComponents(color.CGColor);
            r = components[0];
            g = components[1];
            b = components[2];
            a = components[3];
        }
        self.redSlider.value = r;
        self.greenSlider.value = g;
        self.blueSlider.value = b;
        self.alphaSlider.value = a;
        
        [self _updateDisplay];
    }
    [super show];
}

#pragma mark - Private
- (void)_updateDisplay {
    UIColor *color = [UIColor colorWithRed:self.redSlider.value green:self.greenSlider.value blue:self.blueSlider.value alpha:self.alphaSlider.value];
    self.displayView.backgroundColor = color;
}

@end
