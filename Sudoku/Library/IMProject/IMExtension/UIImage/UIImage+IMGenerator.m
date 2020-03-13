//
//  UIImage+IMGenerator.m
//  ADWallet
//
//  Created by 万涛 on 2019/1/18.
//  Copyright © 2019 AiDian. All rights reserved.
//

#import "UIImage+IMGenerator.h"

@implementation UIImage (IMGenerator)

#pragma mark - 颜色
+ (instancetype)im_imageWithColor:(UIColor *)color {
    return [self im_imageWithColor:color size:CGSizeMake(1.0f, 1.0f)];  //宽高 1.0只要有值就够了
}

+ (instancetype)im_imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);//在这段上下文中获取到颜色UIColor
    CGContextFillRect(context, rect);//用这个颜色填充这个上下文
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)im_gradientImageWithColors:(NSArray *)colors size:(CGSize)size horizontal:(BOOL)horizontal {
    NSMutableArray *colorArray = [NSMutableArray arrayWithCapacity:colors.count];
    for(UIColor *color in colors) {
        [colorArray addObject:(__bridge id)color.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colorArray, NULL);
    CGPoint start;
    CGPoint end;
    
    if (horizontal) {
        start = CGPointMake(0.0, 0.0);
        end = CGPointMake(size.width, 0.0);
    } else {
        start = CGPointMake(0.0, 0.0);
        end = CGPointMake(0.0, size.height);
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - UIView → UIImage
+ (instancetype)im_imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark - 二维码
+ (instancetype)im_imageWithQrCodeStr:(NSString *)qrCodeStr {
    return [self im_imageWithQrCodeStr:qrCodeStr size:200.f];
}

+ (instancetype)im_imageWithQrCodeStr:(NSString *)qrCodeStr size:(CGFloat)size {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [qrCodeStr?:@"" dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"Q" forKey:@"inputCorrectionLevel"];
    CIImage *image = [filter outputImage];
    return [self im_createHDQrCodeImageWithCIImage:image size:size];
}

+ (UIImage *)im_createHDQrCodeImageWithCIImage:(CIImage *)image size:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef cgContext = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [ciContext createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(cgContext, kCGInterpolationNone);
    CGContextScaleCTM(cgContext, scale, scale);
    CGContextDrawImage(cgContext, extent, bitmapImage);
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(cgContext);
    CGContextRelease(cgContext);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(colorSpace);
    UIImage *img = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    return img;
}

@end
