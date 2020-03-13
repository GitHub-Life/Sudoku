//
//  DataFormatVerity.m
//  NiuYan
//
//  Created by 万涛 on 2018/4/21.
//  Copyright © 2018年 niuyan.com. All rights reserved.
//

#import "DataFormatVerity.h"

@implementation DataFormatVerity

static NSString *const PhoneRegexStr = @"^1([38]\\d|4[579]|5[0-35-9]|7[0135-8])\\d{8}$";
static NSString *const IDCodeRegexStr = @"^\\d{17}[\\dXx]{1}$";
//static NSString *const EmailRegexStr = @"^([a-zA-Z\\d_-])+@([a-zA-Z\\d_-])+((\\.[a-zA-Z\\d_-]{2,3}){1,2})$";
static NSString *const EmailRegexStr = @"^[\\w-]+[\\.\\w-]*@[\\w-]+(\\.[\\w-]{2,})?(\\.[a-zA-Z]{2,})$";
static NSString *const PasswordRegexStr = @"^[A-Za-z\\d_\\.\\-\\*@#]{6,20}$";
static NSString *const NumberRegexStr = @"^\\d+$";
static NSString *const NumberOrLetterRegexStr = @"^[a-zA-Z\\d]+$";
static NSString *const HexColorRegexStr = @"^(#|0x|0X)?([\\dA-Fa-f]{3,4}|[\\dA-Fa-f]{6}|[\\dA-Fa-f]{8})$";

+ (BOOL)regexMatchWithString:(NSString *)string regularExpression:(NSString *)regularExpression {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularExpression] evaluateWithObject:string];
}

+ (BOOL)verityDataFormatWithString:(NSString *)string verityFormat:(VerityFormat)verityFormat {
    if (!string.length) return NO;
    switch (verityFormat) {
        case VerityFormatPhone:
            return [self regexMatchWithString:string regularExpression:PhoneRegexStr];
        case VerityFormatIDCode:
            return [self regexMatchWithString:string regularExpression:IDCodeRegexStr];
        case VerityFormatEmail:
            return [self regexMatchWithString:string regularExpression:EmailRegexStr];
        case VerityFormatPassword:
            return [self regexMatchWithString:string regularExpression:PasswordRegexStr];
        case VerityFormatNumber:
            return [self regexMatchWithString:string regularExpression:NumberRegexStr];
        case VerityFormatNumberOrLetter:
            return [self regexMatchWithString:string regularExpression:NumberOrLetterRegexStr];
        case VerityFormatHexColor:
            return [self regexMatchWithString:string regularExpression:HexColorRegexStr];
    }
}

@end
