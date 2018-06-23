//
//  LKDropDownView.m
//  LKGameSDK
//
//  Created by xuguibin on 15-10-21.
//  Copyright (c) 2015年 LKGame. All rights reserved.
//

#import "LKDropDownView.h"

#define GradualDuration 0.3

@interface LKDropDownView ()<UITableViewDataSource,UITableViewDelegate>

/** 数据数组 */
@property (strong, nonatomic) NSArray *dataArray;
/** 下拉框高度 */
@property (assign, nonatomic) CGFloat height;

@end

@implementation LKDropDownView

- (instancetype)initWithFrame:(CGRect)frame andData:(NSArray *)data delegate:(id<LKDropDownViewDelegate>)delegate{
    CGFloat height = frame.size.height;
    frame.size.height = 0.0;
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.dropDownDelegate = delegate;
        self.dataArray = data;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.cellBgColor = [UIColor clearColor];
        self.cellFontColor = [UIColor blackColor];
        self.cellTextAlignment = LKCellTextAlignmentLeft;
        self.isShow = NO;
        self.height = height;
    }
    return self;
}

//显示下拉框
- (void)show {
    _isShow = YES;
    CGRect frame = self.frame;
    frame.size.height = _height;
    [UIView animateWithDuration:GradualDuration animations:^{
        self.frame = frame;
    }];
}

//隐藏下拉框
- (void)dismiss {
    _isShow = NO;
    CGRect frame = self.frame;
    frame.size.height = 0.0;
    [UIView animateWithDuration:GradualDuration animations:^{
        self.frame = frame;
    }];
}

//重新加载数据
- (void)reloadWithData:(NSArray *)data {
    self.dataArray = data;
    [self reloadData];
}

#pragma mark UITableViewDataSource代理方法
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:@"dropDownView"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dropDownView"];
        cell.backgroundColor = _cellBgColor;
        cell.textLabel.textColor = _cellFontColor;
        cell.textLabel.textAlignment = _cellTextAlignment;
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    //附件视图不为空则添加附件视图
    if (_cellAccessoryView != nil) {
        CGFloat cellHeight = [self tableView:nil heightForRowAtIndexPath:nil];
        _cellAccessoryView.frame = CGRectMake(0, 0, cellHeight, cellHeight);
        //通过归档、解档复制视图
        NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:_cellAccessoryView];
        UIView *accessoryView = [NSKeyedUnarchiver unarchiveObjectWithData:archiveData];;
        //如果是按钮类型，则添加点击时间
        if ([accessoryView isMemberOfClass:[UIButton class]]) {
            [((UIButton *)accessoryView) addTarget:self action:@selector(customAccessoryBtnTap:event:) forControlEvents:UIControlEventTouchUpInside];
        }
        cell.accessoryView = accessoryView;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0;
}

#pragma mark UITableViewDelegate代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = _cellBgColor;
    [_dropDownDelegate didSelectedRow:indexPath.row];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if ([_dropDownDelegate respondsToSelector:@selector(didSelectedRow:)]) {
        [_dropDownDelegate didSelectedAccessory:indexPath.row];
    }
}

//自定义accessoryView按钮点击事件
- (void)customAccessoryBtnTap:(id)sender event:(UIEvent *)event {
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self];
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:currentTouchPosition];
    if(indexPath != nil)
    {
        [self tableView:self accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

#pragma mark 重写属性set、get方法
- (NSInteger)selectedRow {
    return self.indexPathForSelectedRow.row;
}

- (void)setSelectedRow:(NSInteger)selectedRow {
    UITableViewScrollPosition position = UITableViewScrollPositionTop;
    if (selectedRow > _dataArray.count / 2) {
        position = UITableViewScrollPositionBottom;
    }
    [self selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedRow inSection:0] animated:NO scrollPosition:position];
}

@end
