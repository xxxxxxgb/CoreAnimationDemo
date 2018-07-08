//
//  Section3ViewController.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/6/29.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "Section3ViewController.h"

@interface Section3ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *hourHand;
@property (weak, nonatomic) IBOutlet UIImageView *minuteHand;
@property (weak, nonatomic) IBOutlet UIImageView *secondHand;

@property (nonatomic, weak) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (strong, nonatomic) CALayer *blueLayer;

@end

@implementation Section3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hourHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.minuteHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.secondHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    [self tick];
    
    self.blueLayer = [CALayer layer];
    self.blueLayer.frame = CGRectMake(150.0f, 50.0f, 150.0f, 150.0f);
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.redView.layer addSublayer:self.blueLayer];
}

- (void)tick {

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    
    CGFloat hoursAngle = ((components.hour + components.minute / 60.0) / 12.0) * M_PI * 2.0;
    CGFloat minsAngle = ((components.minute + components.second / 60.0) / 60.0) * M_PI * 2.0;
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;

    self.hourHand.transform = CGAffineTransformMakeRotation(hoursAngle);
    self.minuteHand.transform = CGAffineTransformMakeRotation(minsAngle);
    self.secondHand.transform = CGAffineTransformMakeRotation(secsAngle);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)geometryFlippedSwitchClicked:(UISwitch *)sender {
    self.view.layer.geometryFlipped = sender.isOn;
}

- (IBAction)zPositionTextFieldEditingDidChanged:(UITextField *)sender {
    self.redView.layer.zPosition = [sender.text floatValue];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CALayer *layer = [self.redView.layer hitTest:point];
    if (layer == self.blueLayer) {
        [[[UIAlertView alloc] initWithTitle:@"hitTest: Inside Blue Layer"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    } else if (layer == self.redView.layer) {
        [[[UIAlertView alloc] initWithTitle:@"hitTest: Inside Red Layer"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
    
    point = [self.redView.layer convertPoint:point fromLayer:self.view.layer];
    if ([self.redView.layer containsPoint:point]) {
        //convert point to blueLayer’s coordinates
        point = [self.blueLayer convertPoint:point fromLayer:self.redView.layer];
        if ([self.blueLayer containsPoint:point]) {
            [[[UIAlertView alloc] initWithTitle:@"containsPoint: Inside Blue Layer"
                                        message:nil
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"containsPoint: Inside Red Layer"
                                        message:nil
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }
#pragma clang diagnostic pop
}

@end
