//
//  Section4ViewController.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/4.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "Section4ViewController.h"
#import "SetRectActionSheet.h"
#import "SetColorActionSheet.h"
#import "ButtonGroup.h"
#import "UIImage+LoadOnBackground.h"

@interface Section4ViewController ()

@property (weak, nonatomic) IBOutlet UIView *whiteView;

@property (strong, nonatomic) SetRectActionSheet *shadowOffsetActionSheet;
@property (strong, nonatomic) SetColorActionSheet *shadowColorActionSheet;

@property (weak, nonatomic) IBOutlet UIButton *circlePathBtn;
@property (weak, nonatomic) IBOutlet UIButton *squarePathBtn;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) ButtonGroup *buttonGroup;

@property (strong, nonatomic) CALayer *maskLayer;

@property (weak, nonatomic) IBOutlet UIView *rectView;
@property (weak, nonatomic) IBOutlet UIView *starView;


@end

@implementation Section4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.buttonGroup = [ButtonGroup buttonGroupWithGroupType:ButtonGroupTypeRadioEnableNoSeleted buttonStatusDidChangeBlock:^(UIButton * _Nonnull button, NSInteger index) {
        UIColor *color = button.isSelected ? [UIColor orangeColor] : [UIColor whiteColor];
        [UIView animateWithDuration:0.3 animations:^{
            [button setBackgroundColor:color];
        }];
        
        weakSelf.imageView.layer.shadowOpacity = button.isSelected ? 0.5f : 0.0f;
        
        if (!button.isSelected) {
            weakSelf.imageView.layer.shadowPath = nil;
        } else {
            CGMutablePathRef path = CGPathCreateMutable();
            button == weakSelf.circlePathBtn ? CGPathAddEllipseInRect(path, NULL, self.imageView.bounds) : CGPathAddRect(path, NULL, weakSelf.imageView.bounds);
            weakSelf.imageView.layer.shadowPath = path;
            CGPathRelease(path);
        }
    }];
    
    [self.buttonGroup addButton:self.circlePathBtn];
    [self.buttonGroup addButton:self.squarePathBtn];
    
    
    self.rectView.layer.contentsGravity = kCAGravityResizeAspect;
    self.starView.layer.contentsGravity = kCAGravityResizeAspect;
    [UIImage loadImageOnBackgroundOfFile:[[NSBundle mainBundle] pathForResource:@"rect" ofType:@"png"] shouldDecompress:NO completedBlock:^(UIImage * _Nullable image) {
        self.rectView.layer.contents = (__bridge id _Nullable)(image.CGImage);
    }];
    [UIImage loadImageOnBackgroundOfFile:[[NSBundle mainBundle] pathForResource:@"star" ofType:@"png"] shouldDecompress:NO completedBlock:^(UIImage * _Nullable image) {
        self.starView.layer.contents = (__bridge id _Nullable)(image.CGImage);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cornerRadiusSliderValueChanged:(UISlider *)sender {
    self.whiteView.layer.cornerRadius = sender.value;
}

- (IBAction)masksToBoundsSwitchClicked:(UISwitch *)sender {
    self.whiteView.layer.masksToBounds = sender.isOn;
}

- (IBAction)shadowOpacitySliderValueChanged:(UISlider *)sender {
    self.whiteView.layer.shadowOpacity = sender.value;
}

- (IBAction)shadowColorBtnClicked:(UIButton *)sender {
    if (self.shadowColorActionSheet == nil) {
        __unused __weak typeof(self) weakSelf = self;
        self.shadowColorActionSheet = [[SetColorActionSheet alloc] initWithCompletedBlock:^(UIColor * _Nonnull color) {
            weakSelf.whiteView.layer.shadowColor = color.CGColor;
            sender.backgroundColor = color;
        }];
    }
    __attribute__((unused))  UIView *view = [UIView new];
    UIColor *color = [UIColor colorWithCGColor:self.whiteView.layer.shadowColor];
    [self.shadowColorActionSheet showWithColor:color];
}

- (IBAction)shadowOffsetBtnClicked:(id)sender {
    if (self.shadowOffsetActionSheet == nil) {
        __weak typeof(self) weakSelf = self;
        self.shadowOffsetActionSheet = [[SetRectActionSheet alloc] initWithMaxSize:CGSizeMake(60, 60) completedBlock:^(CGRect rect) {
            weakSelf.whiteView.layer.shadowOffset = rect.size;
        }];
    }
    [self.shadowOffsetActionSheet showWithSize:self.whiteView.layer.shadowOffset];
}

- (IBAction)shadowRadiusSliderValueChanged:(UISlider *)sender {
    self.whiteView.layer.shadowRadius = sender.value;
}

- (IBAction)maskSwitchClicked:(UISwitch *)sender {
    if (sender.on) {
        if (self.maskLayer == nil) {
            self.maskLayer = [CALayer layer];
            self.maskLayer.frame = self.imageView.bounds;
            UIImage *maskImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image2" ofType:@"png"]];
            self.maskLayer.contents = (__bridge id)maskImage.CGImage;
        }
        self.imageView.layer.mask = self.maskLayer;
    } else {
        self.imageView.layer.mask = nil;
    }
}

- (IBAction)filterSegmentedValueChanged:(UISegmentedControl *)sender {
    NSString *kCAFilter = sender.selectedSegmentIndex == 0 ? kCAFilterLinear : kCAFilterNearest;
    self.rectView.layer.magnificationFilter = kCAFilter;
    self.starView.layer.magnificationFilter = kCAFilter;
}


@end
