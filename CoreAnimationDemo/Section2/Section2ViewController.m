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

@interface Section2ViewController ()<LKDropDownViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *subView;

@property (weak, nonatomic) IBOutlet UIButton *contentsScaleBtn1;
@property (weak, nonatomic) IBOutlet UIButton *contentsScaleBtn2;
@property (weak, nonatomic) IBOutlet UIButton *contentsScaleBtn3;

@property (weak, nonatomic) IBOutlet UIButton *btnContentMode;

@property (strong, nonatomic) ButtonGroup *buttonGroup;

@property (strong, nonatomic) LKDropDownView *dropDownView;
@property (strong, nonatomic) NSArray *typeArray;

@end

@implementation Section2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 不能直接用解压的图片作为contents的内容
    [UIImage loadImageOnBackgroundOfFile:[[NSBundle mainBundle] pathForResource:@"image1" ofType:@"png"] shouldDecompress:NO completed:^(UIImage * _Nullable image) {
        if (image) {
            self.subView.layer.contents = (__bridge id)image.CGImage;
        }
    }];
    
    self.buttonGroup = [ButtonGroup buttonGroupWithExclusive:YES buttonSelectedBlock:^(UIButton *button, NSInteger index) {
        UIColor *color = button.isSelected ? [UIColor orangeColor] : [UIColor whiteColor];
        [UIView animateWithDuration:0.3 animations:^{
            [button setBackgroundColor:color];
        }];
        self.subView.layer.contentsScale = index + 1;
    }];
    
    [self.buttonGroup addButton:self.contentsScaleBtn1];
    [self.buttonGroup addButton:self.contentsScaleBtn2];
    [self.buttonGroup addButton:self.contentsScaleBtn3];

    self.typeArray = @[@"ScaleToFill",
                       @"ScaleAspectFit",
                       @"ScaleAspectFill",
                       @"Redraw",
                       @"Center",
                       @"Top",
                       @"Bottom",
                       @"Left",
                       @"Right",
                       @"TopLeft",
                       @"Right",
                       @"BottomLeft",
                       @"BottomRight"];
    CGRect frame = self.btnContentMode.frame;
    frame.origin.y = frame.origin.y + frame.size.height;
    frame.size.height = 150;
    self.dropDownView = [[LKDropDownView alloc] initWithFrame:frame andData:self.typeArray delegate:self];
    self.dropDownView.cellBgColor = [UIColor orangeColor];
    self.dropDownView.cellFontColor = [UIColor whiteColor];
    self.dropDownView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.dropDownView];
    
    self.btnContentMode.titleLabel.text = self.typeArray[self.subView.contentMode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btnContentModeClicked:(id)sender {
    self.dropDownView.isShow ? [self.dropDownView dismiss] : [self.dropDownView show];
}


- (void)didSelectedRow:(NSInteger)index {
    NSLog(@"index : %ld", index);
    [self.btnContentMode setTitle:self.typeArray[index] forState:UIControlStateNormal];
    self.subView.contentMode = index;
}

@end
