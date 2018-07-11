//
//  AffineTransformViewController.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/10.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "AffineTransformViewController.h"
#import "FormatConversion.h"
#import "SetRectActionSheet.h"

@interface AffineTransformViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray<UITextField *> *affineTransformTextFieldArray;

@property (assign, nonatomic) CGAffineTransform affineTransform;

@property (strong, nonatomic) SetRectActionSheet *scaleActionSheet;
@property (strong, nonatomic) SetRectActionSheet *translateActionSheet;

@end

@implementation AffineTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.affineTransform = CGAffineTransformIdentity;
    [self _updateAffineTransformDisplay];
}

- (IBAction)rotationSliderTouchUpInside:(UISlider *)sender {
    self.affineTransform = CGAffineTransformRotate(self.affineTransform, sender.value * M_PI * 2);
    [self _updateAffineTransformDisplay];
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

- (IBAction)invertBtnClicked:(UIButton *)sender {
    self.affineTransform = CGAffineTransformInvert(self.affineTransform);
    [self _updateAffineTransformDisplay];
}

- (IBAction)resetBtnClicked:(UIButton *)sender {
    self.affineTransform = CGAffineTransformIdentity;
    [self _updateAffineTransformDisplay];
}

- (IBAction)textFieldEditingDidEnd:(UITextField *)sender {
    CGFloat values[6];
    affineTransform2FloatArray(self.affineTransform, values);
    NSInteger index = [self.affineTransformTextFieldArray indexOfObject:sender];
    values[index] = [sender.text floatValue];
    
    self.affineTransform = floatArray2AffineTransform(values);
    [self _updateAffineTransformDisplay];
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

@end
