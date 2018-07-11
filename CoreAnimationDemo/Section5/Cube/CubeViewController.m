//
//  CubeViewController.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/10.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "CubeViewController.h"
#import "FormatConversion.h"
#import <QuartzCore/QuartzCore.h>
#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

@interface CubeViewController ()

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *faces;

@end

@implementation CubeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = - 1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.view.layer.sublayerTransform = perspective;
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self _addFace:0 withTransform:transform];
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self _addFace:1 withTransform:transform];
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self _addFace:2 withTransform:transform];
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self _addFace:3 withTransform:transform];
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self _addFace:4 withTransform:transform];
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self _addFace:5 withTransform:transform];
}

- (void)_applyLightingToFace:(CALayer *)face {
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    CATransform3D transform = face.transform;
    // 原先代码由于版本问题不适用
    GLKMatrix4 matrix4;
    CGFloat values[16];
    transform3D2FloatArray(transform, values);
    for (int i = 0; i < 16; i++) {
        matrix4.m[i] = values[i];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wconditional-uninitialized"
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
#pragma clang diagnostic pop
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}

- (void)_addFace:(NSInteger)index withTransform:(CATransform3D)transform {
    UIView *face = self.faces[index];
    [self.view addSubview:face];
    CGSize containerSize = self.view.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    face.layer.transform = transform;
    [self _applyLightingToFace:face.layer];
}

@end
