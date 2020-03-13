//
//  UIImage+IMGenerator.h
//  ADWallet
//
//  Created by 万涛 on 2019/1/18.
//  Copyright © 2019 AiDian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (IMGenerator)

#pragma mark - 颜色
+ (instancetype)im_imageWithColor:(UIColor *)color;

+ (instancetype)im_imageWithColor:(UIColor *)color size:(CGSize)size;

+ (instancetype)im_gradientImageWithColors:(NSArray *)colors size:(CGSize)size horizontal:(BOOL)horizontal;

#pragma mark - UIView → UIImage
+ (instancetype)im_imageWithView:(UIView *)view;

#pragma mark - 二维码
+ (instancetype)im_imageWithQrCodeStr:(NSString *)qrCodeStr;

+ (instancetype)im_imageWithQrCodeStr:(NSString *)qrCodeStr size:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
