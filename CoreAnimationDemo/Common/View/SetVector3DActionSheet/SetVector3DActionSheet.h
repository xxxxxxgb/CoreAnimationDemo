//
//  SetVector3DActionSheet.h
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/9.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "TBActionSheet.h"

NS_ASSUME_NONNULL_BEGIN

struct Vector3D {
    CGFloat x;
    CGFloat y;
    CGFloat z;
};
typedef struct Vector3D Vector3D;

typedef void(^SetVector3DActionSheetBlock)(Vector3D);

@interface SetVector3DActionSheet : TBActionSheet

- (instancetype)initWithMaxVector3D:(Vector3D)maxVector3D
                     completedBlock:(SetVector3DActionSheetBlock)completedBlock;

- (void)show __attribute__((unavailable("使用-showWithVector3D:")));
- (void)showWithVector3D:(Vector3D)vector3D;
@end

NS_ASSUME_NONNULL_END
