//
//  IMRegex.h
//  ADWallet
//
//  Created by 万涛 on 2019/3/19.
//  Copyright © 2019 AiDian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMRegex : NSObject

/**
 查到符合条件的字符串集合
 @param string 待查找的源字符串
 @param regexStr 条件正则字符串
 @return 符合条件的字符串集合
 */
+ (NSArray *)matchString:(NSString *)string regexStr:(NSString *)regexStr;

/**
 替换符合条件的字符串
 @param string 待替换的源字符串
 @param replaceStr 替换成的字符串
 @param regexStr 条件正则字符串
 @return 替换后的字符串
 */
+ (NSString *)replaceString:(NSString *)string replaceStr:(NSString *)replaceStr regexStr:(NSString *)regexStr;

@end

NS_ASSUME_NONNULL_END
