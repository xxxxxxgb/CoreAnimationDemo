//
//  SetRectActionSheet.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/6/26.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "SetRectActionSheet.h"
#import "UIView+LoadNib.h"

@interface SetRectActionSheet() <TBActionSheetDelegate>
@property (copy, nonatomic) SetRectActionSheetBlock completedBlock;

@property (weak, nonatomic) UISlider *xSlider;
@property (weak, nonatomic) UISlider *ySlider;
@property (weak, nonatomic) UISlider *widthSlider;
@property (weak, nonatomic) UISlider *heightSlider;

@property (weak, nonatomic) UILabel *displayLabel;
@end

@implementation SetRectActionSheet

#pragma mark - API
- (instancetype)initWithMaxPoint:(CGPoint)maxPoint
                  completedBlock:(SetRectActionSheetBlock)completedBlock{
    return [self initWithMaxRect:CGRectMake(maxPoint.x, maxPoint.y, 0, 0) completedBlock:completedBlock];
}

- (instancetype)initWithMaxSize:(CGSize)maxSize
                 completedBlock:(SetRectActionSheetBlock)completedBlock {
    return [self initWithMaxRect:CGRectMake(0, 0, maxSize.width, maxSize.height) completedBlock:completedBlock];
}

- (instancetype)initWithMaxRect:(CGRect)maxRect
                 completedBlock:(SetRectActionSheetBlock)completedBlock {
    
    if (completedBlock == nil) {
        NSLog(@"-initWithCurrentRect:maxRect:completedBlock:方法completedBlock参数不能为空");
        return nil;
    }
    
    self = [super initWithTitle:@"设置矩形" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:nil];
    if (self) {
        self.completedBlock = completedBlock;
        __weak __typeof(self) weakSelf = self;
        self.delegate = weakSelf;
        
        UIView *setRectView = [UIView viewWithNibName:@"SetRectView" shouldCache:YES];
        self.xSlider = setRectView.subviews[0];
        self.ySlider = setRectView.subviews[1];
        self.widthSlider = setRectView.subviews[2];
        self.heightSlider = setRectView.subviews[3];
        self.displayLabel = setRectView.subviews[4];
        self.customView = setRectView;
        
        [self.xSlider addTarget:self action:@selector(updateDisplay) forControlEvents:UIControlEventValueChanged];
        [self.ySlider addTarget:self action:@selector(updateDisplay) forControlEvents:UIControlEventValueChanged];
        [self.widthSlider addTarget:self action:@selector(updateDisplay) forControlEvents:UIControlEventValueChanged];
        [self.heightSlider addTarget:self action:@selector(updateDisplay) forControlEvents:UIControlEventValueChanged];
    

        self.xSlider.maximumValue = maxRect.origin.x;
        self.ySlider.maximumValue = maxRect.origin.y;
        self.widthSlider.maximumValue = maxRect.size.width;
        self.heightSlider.maximumValue = maxRect.size.height;
        
        [self addButtonWithTitle:@"确定" style:TBActionButtonStyleDefault handler:^(TBActionButton * _Nonnull button) {
            if (weakSelf.completedBlock) {
                CGRect rect = CGRectMake(weakSelf.xSlider.value, weakSelf.ySlider.value, weakSelf.widthSlider.value, weakSelf.heightSlider.value);
                weakSelf.completedBlock(rect);
            }
        }];
    }
    return self;
}

- (void)show {
    NSAssert(false, @"[SetRectActionSheet-show]方法弃用");
}

- (void)showWithPoint:(CGPoint)point {
    self.xSlider.value = point.x;
    self.ySlider.value = point.y;
    self.widthSlider.enabled = NO;
    self.heightSlider.enabled = NO;
    
    [super show];
}

- (void)showWithSize:(CGSize)size {
    self.xSlider.enabled = NO;
    self.ySlider.enabled = NO;
    self.widthSlider.value = size.width;
    self.heightSlider.value = size.height;
    
    [super show];
}

- (void)showWithRect:(CGRect)rect {
    self.xSlider.value = rect.origin.x;
    self.ySlider.value = rect.origin.y;
    self.widthSlider.value = rect.size.width;
    self.heightSlider.value = rect.size.height;
    
    [super show];
}

#pragma mark - Private
- (void)updateDisplay {
    NSString *curRectString = [NSString stringWithFormat:@"{%.2f, %.2f, %.2f, %.2f}", self.xSlider.value, self.ySlider.value, self.widthSlider.value, self.heightSlider.value];
    self.displayLabel.text = curRectString;
}

@end
