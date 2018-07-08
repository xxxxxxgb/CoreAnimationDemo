//
//  LKDropDownView.h
//  LKGameSDK
//
//  Created by xuguibin on 15-10-21.
//  Copyright (c) 2015年 LKGame. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LKDropDownViewDelegate <NSObject>

@required
- (void)didSelectedRow:(NSInteger)index;

@optional
- (void)didSelectedAccessory:(NSInteger)index;

@end

typedef NS_ENUM(NSInteger, LKCellTextAlignment){
    LKCellTextAlignmentLeft   = 0,
    LKCellTextAlignmentCenter = 1,
    LKCellTextAlignmentRight  = 2,
};

/**
 *  下拉框视图
 */
@interface LKDropDownView : UITableView

@property (weak, nonatomic) id<LKDropDownViewDelegate> dropDownDelegate;

/** 视图状态属性，是否显示 */
@property (assign, nonatomic) BOOL isShow;
/** 单元格背景颜色 */
@property (strong, nonatomic) UIColor *cellBgColor;
/** 单元格字体颜色 */
@property (strong, nonatomic) UIColor *cellFontColor;
/** 单元格附件视图 */
@property (strong, nonatomic) UIView *cellAccessoryView;
/** 单元格字符串位置 */
@property (assign, nonatomic) LKCellTextAlignment cellTextAlignment;
/** 选中行 */
@property (assign, nonatomic) NSInteger selectedRow;

/**
 *  初始化方法
 *
 *  @param data     显示的数据数组
 *  @param delegate LKDropDownViewDelegate代理类
 */
- (instancetype)initWithFrame:(CGRect)frame andData:(NSArray *)data delegate:(id<LKDropDownViewDelegate>)delegate;

/**
 *  显示下拉框
 */
- (void)show;

/**
 *  隐藏下拉框
 */
- (void)dismiss;

/**
 *  重新加载数据
 */
- (void)reloadWithData:(NSArray *)data;

@end
