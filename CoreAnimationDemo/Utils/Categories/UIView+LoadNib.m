//
//  UIView+LoadNib.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/4.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "UIView+LoadNib.h"

@implementation UIView (LoadNib)

+ (UIView *)viewWithNibName:(NSString *)nibName {
    return [self viewWithNibName:nibName owner:nil shouldCache:NO];
}

+ (UIView *)viewWithNibName:(NSString *)nibName owner:(id)owner {
    return [self viewWithNibName:nibName owner:owner shouldCache:NO];
}

+ (UIView *)viewWithNibName:(NSString *)nibName shouldCache:(BOOL)shouldCache {
    return [self viewWithNibName:nibName owner:nil shouldCache:shouldCache];
}

+ (UIView *)viewWithNibName:(NSString *)nibName owner:(id)owner shouldCache:(BOOL)shouldCache {
    if (nibName == nil) return nil;
    
    static NSCache *nibCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nibCache = [[NSCache alloc] init];
    });
    
    UINib *nib = [nibCache objectForKey:nibName];
    if (nib == nil) {
        nib = [UINib nibWithNibName:nibName bundle:nil];
    }
    
    if (shouldCache) {
        [nibCache setObject:nib forKey:nibName];
    }
    
    NSArray *views = [nib instantiateWithOwner:owner options:nil];
    if (views.count > 0) return (UIView *)views[0];
    return nil;
}

@end
