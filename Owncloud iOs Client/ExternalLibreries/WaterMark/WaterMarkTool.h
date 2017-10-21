//
//  WaterMarkTool.h
//  watermarktest
//
//  Created by KSY-iOS on 17/10/13.
//  Copyright © 2017年 dingxiankun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WaterMarkTool : NSObject

+ (UIImage *)waterMarkWithImage:(UIImage *)image1 size:(CGSize)size;
+ (UIImage *)waterMarkWithSize:(CGSize)size;
@end
