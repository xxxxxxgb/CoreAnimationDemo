//
//  Section2ViewController.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/6/22.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "Section2ViewController.h"
#import "UIImage+LoadOnBackground.h"
#import "ButtonGroup.h"
#import "LKDropDownView.h"
#import "SetRectActionSheet.h"

@interface Section2ViewController ()<LKDropDownViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *subView;

@property (weak, nonatomic) IBOutlet UIButton *contentModeBtn;

@property (strong, nonatomic) LKDropDownView *dropDownView;
@property (strong, nonatomic) NSArray *typeArray;

@property (strong, nonatomic) SetRectActionSheet *setContentsRectActionSheet;
@property (strong, nonatomic) SetRectActionSheet *setContentsCenterActionSheet;

@end

@implementation Section2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 不能用解压的图片作为contents的内容
    [UIImage loadImageOnBackgroundOfFile:[[NSBundle mainBundle] pathForResource:@"image1" ofType:@"png"] shouldDecompress:NO completedBlock:^(UIImage * _Nullable image) {
        if (image) {
            self.subView.layer.contents = (__bridge id)image.CGImage;
        }
    }];

    self.typeArray = @[@"center",
                        @"top",
                        @"bottom",
                        @"left",
                        @"right",
                        @"topLeft",
                        @"topRight",
                        @"bottomLeft",
                        @"bottomRight",
                        @"resize",
                        @"resizeAspect",
                        @"resizeAspectFill"];
    CGRect frame = self.contentModeBtn.frame;
    frame.origin.y = frame.origin.y + frame.size.height;
    frame.size.height = 150;
    self.dropDownView = [[LKDropDownView alloc] initWithFrame:frame andData:self.typeArray delegate:self];
    self.dropDownView.cellBgColor = [UIColor orangeColor];
    self.dropDownView.cellFontColor = [UIColor whiteColor];
    self.dropDownView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.dropDownView];

    self.contentModeBtn.titleLabel.text = self.typeArray[self.subView.contentMode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)contentModeBtnClicked:(id)sender {
    self.dropDownView.isShow ? [self.dropDownView dismiss] : [self.dropDownView show];
}

- (IBAction)contentsScaleSegmentedValueChanged:(UISegmentedControl *)sender {
    self.subView.layer.contentsScale = sender.selectedSegmentIndex + 1;
}

- (IBAction)contentsRectBtnClicked:(id)sender {
    if (self.setContentsRectActionSheet == nil) {
        __weak typeof(self) weakSelf = self;
        self.setContentsRectActionSheet = [[SetRectActionSheet alloc] initWithMaxRect:CGRectMake(1, 1, 1, 1) completedBlock:^(CGRect rect) {
            weakSelf.subView.layer.contentsRect = rect;
        }];
    }
    [self.setContentsRectActionSheet showWithRect:self.subView.layer.contentsRect];
}

- (IBAction)contentsCenterBtnClicked:(id)sender {
    if (self.setContentsCenterActionSheet == nil) {
        __weak typeof(self) weakSelf = self;
        self.setContentsCenterActionSheet = [[SetRectActionSheet alloc] initWithMaxRect:CGRectMake(1, 1, 1, 1) completedBlock:^(CGRect rect) {
            weakSelf.subView.layer.contentsCenter = rect;
        }];
    }
    [self.setContentsCenterActionSheet showWithRect:self.subView.layer.contentsCenter];
}

- (IBAction)maskToBoundsSwitchClicked:(UISwitch *)sender {
    self.subView.layer.masksToBounds = sender.isOn;
}

#pragma mark - LKDropDownViewDelegate

- (void)didSelectedRow:(NSInteger)index {
    [self.contentModeBtn setTitle:self.typeArray[index] forState:UIControlStateNormal];
    self.subView.layer.contentsGravity = self.typeArray[index];
}


@end
