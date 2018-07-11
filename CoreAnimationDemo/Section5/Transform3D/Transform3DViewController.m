//
//  Transform3DViewController.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/10.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "Transform3DViewController.h"
#import "FormatConversion.h"

@interface Transform3DViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@property (weak, nonatomic) IBOutlet UISegmentedControl *coordinateSegmented;

@property (assign, nonatomic) CATransform3D transform3D;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray<UITextField *> *transform3DTextFieldArray;

@end

@implementation Transform3DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)rotationSliderTouchUpInside:(UISlider *)sender {
    float angle = sender.value * M_PI * 2;
    float values[3] = {0.0f};
    values[self.coordinateSegmented.selectedSegmentIndex] = 1.0f;
    self.transform3D = CATransform3DRotate(self.transform3D, angle, values[0], values[1], values[2]);
    
    [self _updateTransform3DDisplay];
    
    sender.value = 0.0f;
}

- (IBAction)textFieldEditingDidEnd:(UITextField *)sender {
    CGFloat values[9];
    transform3D2FloatArray(self.transform3D, values);
    
    NSInteger index = [self.transform3DTextFieldArray indexOfObject:sender];
    values[index] = [sender.text floatValue];
    self.transform3D = floatArray2Transform3D(values);
    [self _updateTransform3DDisplay];
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

@end
