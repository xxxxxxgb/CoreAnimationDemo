//
//  FormatConversion.m
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/10.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import "FormatConversion.h"

void affineTransform2FloatArray(CGAffineTransform affineTransform, CGFloat *array) {
    array[0] = affineTransform.a;
    array[1] = affineTransform.b;
    array[2] = affineTransform.c;
    array[3] = affineTransform.d;
    array[4] = affineTransform.tx;
    array[5] = affineTransform.ty;
}

CGAffineTransform floatArray2AffineTransform(CGFloat *array) {
    return CGAffineTransformMake(array[0], array[1], array[2], array[3], array[4], array[5]);
}

void transform3D2FloatArray(CATransform3D transform3D, CGFloat *array) {
    array[0] = transform3D.m11;
    array[1] = transform3D.m12;
    array[2] = transform3D.m13;
    array[3] = transform3D.m14;
    array[4] = transform3D.m21;
    array[5] = transform3D.m22;
    array[6] = transform3D.m23;
    array[7] = transform3D.m24;
    array[8] = transform3D.m31;
    array[9] = transform3D.m32;
    array[10] = transform3D.m33;
    array[11] = transform3D.m34;
    array[12] = transform3D.m41;
    array[13] = transform3D.m42;
    array[14] = transform3D.m43;
    array[15] = transform3D.m44;
}

CATransform3D floatArray2Transform3D(CGFloat *array) {
    CATransform3D transform3D;
    transform3D.m11 = array[0];
    transform3D.m12 = array[1];
    transform3D.m13 = array[2];
    transform3D.m14 = array[3];
    transform3D.m21 = array[4];
    transform3D.m22 = array[5];
    transform3D.m23 = array[6];
    transform3D.m24 = array[7];
    transform3D.m31 = array[8];
    transform3D.m32 = array[9];
    transform3D.m33 = array[10];
    transform3D.m34 = array[11];
    transform3D.m41 = array[12];
    transform3D.m42 = array[13];
    transform3D.m43 = array[14];
    transform3D.m44 = array[15];
    return transform3D;
}

@implementation FormatConversion
@end
