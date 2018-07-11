//
//  FormatConversion.h
//  CoreAnimationDemo
//
//  Created by 许桂斌 on 2018/7/10.
//  Copyright © 2018年 xgb. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void affineTransform2FloatArray(CGAffineTransform affineTransform, CGFloat *array);
extern CGAffineTransform floatArray2AffineTransform(CGFloat *array);

extern void transform3D2FloatArray(CATransform3D transform3D, CGFloat *array);
extern CATransform3D floatArray2Transform3D(CGFloat *array);

@interface FormatConversion : NSObject
@end
