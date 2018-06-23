//
//  UIImage+Compress.h
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/6/23.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoadImageCompletionBlock)(UIImage * _Nullable image);

@interface UIImage (LoadOnBackground)

+ (void)loadImageOnBackgroundOfFile:(NSString *)path
                          completed:(LoadImageCompletionBlock)completedBlock;

+ (void)loadImageOnBackgroundOfFile:(NSString *)path
                   shouldDecompress:(BOOL)shouldDecompress
                          completed:(LoadImageCompletionBlock)completedBlock;

@end
