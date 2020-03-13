//
//  DataFormatVerity.h
//  NiuYan
//
//  Created by 万涛 on 2018/4/21.
//  Copyright © 2018年 niuyan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, VerityFormat) {
    VerityFormatPhone = 0,
    VerityFormatIDCode,
    VerityFormatEmail,
    VerityFormatPassword,
    VerityFormatNumber,
    VerityFormatNumberOrLetter,
    VerityFormatHexColor
};

@interface DataFormatVerity : NSObject

+ (BOOL)verityDataFormatWithString:(NSString *)string verityFormat:(VerityFormat)verityFormat;

@end
