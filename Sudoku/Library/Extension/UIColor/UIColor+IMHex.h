//
//  UIColor+IMHex.h
//  Bullseye
//
//  Created by 万涛 on 2018/11/16.
//  Copyright © 2018 niuyan.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (IMHex)

+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHexStr:(NSString *)hexStr;
- (NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
