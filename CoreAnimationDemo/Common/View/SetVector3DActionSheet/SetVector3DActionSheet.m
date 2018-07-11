//
//  SetVector3DActionSheet.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/9.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "SetVector3DActionSheet.h"
#import "UIView+LoadNib.h"

@interface SetVector3DActionSheet() <TBActionSheetDelegate>
@property (copy, nonatomic) SetVector3DActionSheetBlock completedBlock;

@property (weak, nonatomic) UISlider *xSlider;
@property (weak, nonatomic) UISlider *ySlider;
@property (weak, nonatomic) UISlider *zSlider;

@property (weak, nonatomic) UILabel *displayLabel;
@end

@implementation SetVector3DActionSheet

#pragma mark - API
- (instancetype)initWithMaxVector3D:(Vector3D)maxVector3D
                     completedBlock:(SetVector3DActionSheetBlock)completedBlock {
    if (completedBlock == nil) {
        NSLog(@"[SetCoordinateActionSheet -initWithMaxVector3D:completedBlock:]方法completedBlock参数不能为空");
        return nil;
    }
    
    self = [super initWithTitle:@"设置矩形" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:nil];
    if (self) {
        self.completedBlock = completedBlock;
        __weak __typeof(self) weakSelf = self;
        self.delegate = weakSelf;
        
        UIView *setCoordinateView = [UIView viewWithNibName:@"SetCoordinateView" shouldCache:YES];
        self.xSlider = setCoordinateView.subviews[0];
        self.ySlider = setCoordinateView.subviews[1];
        self.zSlider = setCoordinateView.subviews[2];
        self.customView = setCoordinateView;
        
        [self.xSlider addTarget:self action:@selector(_updateDisplay) forControlEvents:UIControlEventValueChanged];
        [self.ySlider addTarget:self action:@selector(_updateDisplay) forControlEvents:UIControlEventValueChanged];
        [self.zSlider addTarget:self action:@selector(_updateDisplay) forControlEvents:UIControlEventValueChanged];
        
        self.xSlider.maximumValue = maxVector3D.x;
        self.ySlider.maximumValue = maxVector3D.y;
        self.zSlider.maximumValue = maxVector3D.z;
        
        [self addButtonWithTitle:@"确定" style:TBActionButtonStyleDefault handler:^(TBActionButton * _Nonnull button) {
            if (weakSelf.completedBlock) {
                Vector3D vector3D;
                vector3D.x = weakSelf.xSlider.value;
                vector3D.y = weakSelf.ySlider.value;
                vector3D.z = weakSelf.zSlider.value;
                weakSelf.completedBlock(vector3D);
            }
        }];
    }
    return self;
}

- (void)show {
    NSAssert(false, @"[SetCoordinateActionSheet -show]方法弃用");
}

- (void)showWithVector3D:(Vector3D)vector3D {
    self.xSlider.value = vector3D.x;
    self.xSlider.value = vector3D.y;
    self.xSlider.value = vector3D.z;
    [self _updateDisplay];
    
    [super show];
}

#pragma mark - Private
- (void)_updateDisplay {
    NSString *description = [NSString stringWithFormat:@"{%.2f, %.2f, %.2f}", self.xSlider.value, self.ySlider.value, self.zSlider.value];
    self.displayLabel.text = description;
}

@end
