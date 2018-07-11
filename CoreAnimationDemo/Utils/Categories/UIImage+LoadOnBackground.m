//
//  UIImage+Compress.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/6/23.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "UIImage+LoadOnBackground.h"


@implementation UIImage (LoadOnBackground)

+ (void)loadImageOnBackgroundOfFile:(NSString *)path
                     completedBlock:(LoadImageCompletionBlock)completedBlock {
    [self loadImageOnBackgroundOfFile:path shouldDecompress:YES completedBlock:completedBlock];
}

+ (void)loadImageOnBackgroundOfFile:(NSString *)path
                   shouldDecompress:(BOOL)shouldDecompress
                     completedBlock:(LoadImageCompletionBlock)completedBlock {
    
    if (path == nil || completedBlock == nil) {
        NSLog(@"[UIImage +loadImageOnBackgroundOfFile:shouldDecompress:completedBlock:]方法的path和completedBlock参数不能为空");
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        if (image && image.images == nil && shouldDecompress) {
            CGImageRef imageRef = image.CGImage;
            
            if (imageRef) {
                CGColorSpaceRef colorSpaceRef = CGImageGetColorSpace(imageRef);
                CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(colorSpaceRef);
                
                if (colorSpaceModel == kCGColorSpaceModelCMYK) {
                    CGImageRelease(imageRef);
                    imageRef = NULL;
                    goto callback;
                }
            }
            
            CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
            CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(colorSpaceRef);
            
            CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
            if (colorSpaceModel == kCGColorSpaceModelRGB) {
                uint32_t alpha = (bitmapInfo & kCGBitmapAlphaInfoMask);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wassign-enum"
                if (alpha == kCGImageAlphaNone) {
                    bitmapInfo &= ~kCGBitmapAlphaInfoMask;
                    bitmapInfo |= kCGImageAlphaNoneSkipFirst;
                } else if (!(alpha == kCGImageAlphaNoneSkipFirst || alpha == kCGImageAlphaNoneSkipLast)) {
                    bitmapInfo &= ~kCGBitmapAlphaInfoMask;
                    bitmapInfo |= kCGImageAlphaPremultipliedFirst;
                }
#pragma clang diagnostic pop
            }
            
            size_t width = CGImageGetWidth(imageRef);
            size_t height = CGImageGetHeight(imageRef);
            size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
            
            CGContextRef context = CGBitmapContextCreate(NULL,
                                                         width,
                                                         height,
                                                         bitsPerComponent,
                                                         0,
                                                         colorSpaceRef,
                                                         bitmapInfo);
            
            CGColorSpaceRelease(colorSpaceRef);
            
            if (context == NULL) {
                CGImageRelease(imageRef);
                goto callback;
            }
            
            CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, width, height), imageRef);
            CGImageRef decompressImageRef = CGBitmapContextCreateImage(context);
            
            CGContextRelease(context);
            CGImageRelease(imageRef);
            
            image = [[UIImage alloc] initWithCGImage:decompressImageRef scale:image.scale orientation:image.imageOrientation];
            
            CGImageRelease(decompressImageRef);
        }
        
    callback:
        if (completedBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completedBlock(image);
            });
        }
    });
}

@end
