//
//  Section5ViewController.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/9.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "Section5ViewController.h"
#import "SetRectActionSheet.h"
#import <QuartzCore/QuartzCore.h>
#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

@interface Section5ViewController ()

#pragma mark - CGAffineTransform property

@property (strong, nonatomic) IBOutlet UIView *affineTransformView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray<UITextField *> *affineTransformTextFieldArray;

@property (assign, nonatomic) CGAffineTransform affineTransform;

@property (strong, nonatomic) SetRectActionSheet *scaleActionSheet;
@property (strong, nonatomic) SetRectActionSheet *translateActionSheet;

#pragma mark - CATransform3D property

@property (strong, nonatomic) IBOutlet UIView *transform3DView;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@property (weak, nonatomic) IBOutlet UISegmentedControl *coordinateSegmented;

@property (assign, nonatomic) CATransform3D transform3D;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray<UITextField *> *transform3DTextFieldArray;

#pragma mark - 固态对象 property

@property (strong, nonatomic) IBOutlet UIView *cubeView;

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *faces;

@end

#pragma mark -

@implementation Section5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.affineTransformView];
    CGRect frame = self.transform3DView.frame;
    frame.origin.x = frame.size.width;
    self.transform3DView.frame = frame;
    [self.view addSubview:self.transform3DView];
    frame.origin.x = frame.size.width * 2;
    self.cubeView.frame = frame;
    [self.view addSubview:self.cubeView];
    
    UIScrollView * scrollView = (UIScrollView *)self.view;
    [scrollView setContentSize:CGSizeMake(frame.size.width * 3, frame.size.height)];
    
    // 仿射矩阵
    self.affineTransform = CGAffineTransformIdentity;
    [self _updateAffineTransformDisplay];
    
    // 3D矩阵
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = - 1.0 / 500.0;
    self.transform3D = perspective;
    [self _updateTransform3DDisplay];
    
    // 固体对象
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.cubeView.layer.sublayerTransform = perspective;
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

- (IBAction)rotationSliderTouchUpInside:(UISlider *)sender {
    if (sender.tag == 0) {
        self.affineTransform = CGAffineTransformRotate(self.affineTransform, sender.value * M_PI * 2);
        [self _updateAffineTransformDisplay];
    } else {
        float angle = sender.value * M_PI * 2;
        float values[3] = {0.0f};
        values[self.coordinateSegmented.selectedSegmentIndex] = 1.0f;
        self.transform3D = CATransform3DRotate(self.transform3D, angle, values[0], values[1], values[2]);
        
        [self _updateTransform3DDisplay];
        
        sender.value = 0.0f;
    }
}

- (IBAction)scaleBtnClicked:(id)sender {
    if (self.scaleActionSheet == nil) {
        __weak typeof(self) weakSelf = self;
        self.scaleActionSheet = [[SetRectActionSheet alloc] initWithMaxSize:CGSizeMake(2.0f, 2.0f) completedBlock:^(CGRect rect) {
            weakSelf.affineTransform = CGAffineTransformScale(weakSelf.affineTransform, rect.size.width, rect.size.height);
            [weakSelf _updateAffineTransformDisplay];
        }];
    }
    [self.scaleActionSheet showWithSize:CGSizeMake(1.0f, 1.0f)];
}

- (IBAction)translateBtnClicked:(id)sender {
    if (self.translateActionSheet == nil) {
        __weak typeof(self) weakSelf = self;
        self.translateActionSheet = [[SetRectActionSheet alloc] initWithMaxPoint:CGPointMake(200, 200) completedBlock:^(CGRect rect) {
            weakSelf.affineTransform = CGAffineTransformTranslate(weakSelf.affineTransform, rect.origin.x, rect.origin.y);
            [weakSelf _updateAffineTransformDisplay];
        }];
    }
    [self.translateActionSheet showWithPoint:CGPointMake(0, 0)];
}

- (IBAction)resetBtnClicked:(UIButton *)sender {
    self.affineTransform = CGAffineTransformIdentity;
    [self _updateAffineTransformDisplay];
}

- (IBAction)invertBtnClicked:(UIButton *)sender {
    self.affineTransform = CGAffineTransformInvert(self.affineTransform);
    [self _updateAffineTransformDisplay];
}

- (IBAction)textFieldEditingDidEnd:(UITextField *)sender {
    if ([self.affineTransformTextFieldArray containsObject:sender]) {
        CGFloat values[6];
        affineTransform2FloatArray(self.affineTransform, values);
        NSInteger index = [self.affineTransformTextFieldArray indexOfObject:sender];
        values[index] = [sender.text floatValue];
        
        self.affineTransform = floatArray2AffineTransform(values);
        [self _updateAffineTransformDisplay];
    } else {
        CGFloat values[9];
        transform3D2FloatArray(self.transform3D, values);
        
        NSInteger index = [self.transform3DTextFieldArray indexOfObject:sender];
        values[index] = [sender.text floatValue];
        self.transform3D = floatArray2Transform3D(values);
        [self _updateTransform3DDisplay];
    }
}

- (void)_updateAffineTransformDisplay {
    self.imageView.layer.affineTransform = self.affineTransform;

    CGFloat values[6];
    affineTransform2FloatArray(self.affineTransform, values);
    
    for (NSInteger i = 0; i < 6; i++) {
        NSString *description = i < 4 ? [NSString stringWithFormat:@"%.4f", values[i]] : [NSString stringWithFormat:@"%.0f", values[i]];
        self.affineTransformTextFieldArray[i].text = description;
    }
}

- (void)_updateTransform3DDisplay {
    self.containerView.layer.sublayerTransform = self.transform3D;
    
    CGFloat values[16];
    transform3D2FloatArray(self.transform3D, values);
    
    for (NSInteger i = 0; i < 16; i++) {
        NSString *description = [NSString stringWithFormat:@"%.4f", values[i]];
        self.transform3DTextFieldArray[i].text = description;
    }
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
    [self.cubeView addSubview:face];
    CGSize containerSize = self.cubeView.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    face.layer.transform = transform;
    [self _applyLightingToFace:face.layer];
}

void affineTransform2FloatArray(CGAffineTransform affineTransform, CGFloat *array) {
    array[0] = affineTransform.a;
    array[1] = affineTransform.b;
    array[2] = affineTransform.c;
    array[3] = affineTransform.d;
    array[4] = affineTransform.tx;
    array[5] = affineTransform.ty;
}

CGAffineTransform floatArray2AffineTransform(CGFloat *array) {
    return CGAffineTransformMake(array[0], array[1], array[2], array[3], array[4], array[5]);
}

void transform3D2FloatArray(CATransform3D transform3D, CGFloat *array) {
    array[0] = transform3D.m11;
    array[1] = transform3D.m12;
    array[2] = transform3D.m13;
    array[3] = transform3D.m14;
    array[4] = transform3D.m21;
    array[5] = transform3D.m22;
    array[6] = transform3D.m23;
    array[7] = transform3D.m24;
    array[8] = transform3D.m31;
    array[9] = transform3D.m32;
    array[10] = transform3D.m33;
    array[11] = transform3D.m34;
    array[12] = transform3D.m41;
    array[13] = transform3D.m42;
    array[14] = transform3D.m43;
    array[15] = transform3D.m44;
}

CATransform3D floatArray2Transform3D(CGFloat *array) {
    CATransform3D transform3D;
    transform3D.m11 = array[0];
    transform3D.m12 = array[1];
    transform3D.m13 = array[2];
    transform3D.m14 = array[3];
    transform3D.m21 = array[4];
    transform3D.m22 = array[5];
    transform3D.m23 = array[6];
    transform3D.m24 = array[7];
    transform3D.m31 = array[8];
    transform3D.m32 = array[9];
    transform3D.m33 = array[10];
    transform3D.m34 = array[11];
    transform3D.m41 = array[12];
    transform3D.m42 = array[13];
    transform3D.m43 = array[14];
    transform3D.m44 = array[15];
    return transform3D;
}

@end
