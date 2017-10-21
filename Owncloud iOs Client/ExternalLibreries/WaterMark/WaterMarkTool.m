//
//  WaterMarkTool.m
//  watermarktest
//
//  Created by KSY-iOS on 17/10/13.
//  Copyright © 2017年 dingxiankun. All rights reserved.
//

#import "WaterMarkTool.h"

@implementation WaterMarkTool

+ (UIImage *)waterMarkWithImage:(UIImage *)image1 size:(CGSize)size {
    
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image2 = [WaterMarkTool addWaterMark:coverView contentSize:size];
    
    UIGraphicsBeginImageContext(size);
    [image1 drawInRect:CGRectMake(0, 0, size.width, size.height)];
    [image2 drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *syntheticImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return syntheticImage;
}
+ (UIImage *)waterMarkWithSize:(CGSize)size {
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    coverView.backgroundColor = [UIColor clearColor];
    UIImage *image1 = [WaterMarkTool addWaterMark:coverView contentSize:size];
    
    return image1;
}
// 添加水印
+ (UIImage *)addWaterMark:(UIView *)coverView contentSize:(CGSize)contentSize {
    
    NSString *loginNameBase64 = @"";
    NSString *watermark = @"保密文档  禁止复制";
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        for ( int i=0; i<9; i++ )
        {
            NSInteger row = i/3;
            NSInteger col = i%3;
            
            // Button Frame
            NSInteger distance = contentSize.width/4;
            NSInteger size = distance/1.52;
            NSInteger margin = size;
            
            UILabel *fLabel = [ [UILabel alloc] initWithFrame:CGRectMake(col*distance + margin/3 , row*distance+i*45, size*3, size) ];
            fLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold"  size:(25.0)];
            fLabel.textColor = [ UIColor lightGrayColor ];
            fLabel.backgroundColor = [ UIColor clearColor ];
            fLabel.text = watermark;
            fLabel.transform = CGAffineTransformMakeRotation(-0.4);
            
            UILabel *wmLabel = [ [UILabel alloc] initWithFrame:CGRectMake(col*distance + margin/2, row*distance+i*45+65, size, size) ];
            wmLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold"  size:(17.0)];
            wmLabel.textColor = [ UIColor lightGrayColor ];
            wmLabel.text = loginNameBase64;
            wmLabel.transform = CGAffineTransformMakeRotation(-0.4);
            
            [coverView addSubview:wmLabel];
            [coverView addSubview:fLabel];
        }
    }
    else
    {
        for ( int i=0; i<4; i++ )
        {
            NSInteger row = i/2;
            NSInteger col = i%2;
            
            // Button Frame
            NSInteger distance = contentSize.width/3;
            NSInteger size = distance/1.52;
            NSInteger margin = size;
            
            UILabel *fLabel = [ [UILabel alloc] initWithFrame:CGRectMake(col*distance + margin*0.8 , row*size*2 + i*50 + 100, size*3, size) ];
            fLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold"  size:(18.0)];
            fLabel.textColor = [ UIColor lightGrayColor ];
            fLabel.text = watermark;
            fLabel.transform = CGAffineTransformMakeRotation(-0.5);
            
            UILabel *wmLabel = [ [UILabel alloc] initWithFrame:CGRectMake(col*distance + margin , row*size*2 + i*50 + 130, size*2, size) ];
            wmLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold"  size:(15.0)];
            wmLabel.textColor = [ UIColor lightGrayColor ];
            wmLabel.text = loginNameBase64;
            wmLabel.textAlignment = NSTextAlignmentCenter;
            wmLabel.transform = CGAffineTransformMakeRotation(-0.5);
            
            [coverView addSubview:wmLabel];
            [coverView addSubview:fLabel];
        }
    }
    
    return [WaterMarkTool convertViewToImage:coverView];
}

+ (UIImage *)convertViewToImage:(UIView*)v {
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
