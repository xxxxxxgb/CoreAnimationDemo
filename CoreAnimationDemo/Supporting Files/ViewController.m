//
//  ViewController.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/6/22.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "ViewController.h"

#import "BaseViewController.h"
#import "Section2ViewController.h"

@interface ViewController ()
@property NSMutableArray<BaseViewController *> *viewControllerArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewControllerArray = [NSMutableArray new];
    
    [self.viewControllerArray addObject:[Section2ViewController viewControllerWithTitle:@"寄宿图"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewControllerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString  * const reuseIdentifier = @"reuseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.viewControllerArray[indexPath.row].title;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:self.viewControllerArray[indexPath.row] animated:YES];
}

@end
