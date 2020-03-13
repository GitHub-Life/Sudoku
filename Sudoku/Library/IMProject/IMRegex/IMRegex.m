//
//  IMRegex.m
//  ADWallet
//
//  Created by 万涛 on 2019/3/19.
//  Copyright © 2019 AiDian. All rights reserved.
//

#import "IMRegex.h"

@implementation IMRegex

#pragma mark - Regex
+ (NSArray *)matchString:(NSString *)string regexStr:(NSString *)regexStr {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray * matches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    //match: 所有匹配到的字符,根据() 包含级
    NSMutableArray *array = [NSMutableArray array];
    for (NSTextCheckingResult *match in matches) {
        for (int i = 0; i < [match numberOfRanges]; i++) {
            //以正则中的(),划分成不同的匹配部分
            NSString *component = [string substringWithRange:[match rangeAtIndex:i]];
            [array addObject:component];
        }
    }
    return array;
}

+ (NSString *)replaceString:(NSString *)string replaceStr:(NSString *)replaceStr regexStr:(NSString *)regexStr {
    if (!string.length) return string;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:nil];
    string  = [regex stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:replaceStr];
    return string;
}

@end
