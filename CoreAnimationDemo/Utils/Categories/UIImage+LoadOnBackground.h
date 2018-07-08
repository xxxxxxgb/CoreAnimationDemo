//
//  UIImage+Compress.h
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/6/23.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoadImageCompletionBlock)(UIImage * _Nullable image);

/**
 * 扩展图片在后台进程加载并解压的功能。
 */
@interface UIImage (LoadOnBackground)
/**
 *  在后台进程加载图片并对图片进行解压，异步回调加载完成的图片。
 *
 *  @param path           图片文件路径。
 *  @param completedBlock 加载完成时的回调。
 */
+ (void)loadImageOnBackgroundOfFile:(NSString *)path
                     completedBlock:(LoadImageCompletionBlock)completedBlock;

/**
 *  在后台进程加载图片并对图片进行解压，异步回调加载完成的图片。
 *
 *  @param path             图片文件路径。
 *  @param shouldDecompress 是否解压图片。
 *  @param completedBlock   加载完成时的回调。
 */
+ (void)loadImageOnBackgroundOfFile:(NSString *)path
                   shouldDecompress:(BOOL)shouldDecompress
                     completedBlock:(LoadImageCompletionBlock)completedBlock;
@end

NS_ASSUME_NONNULL_END
