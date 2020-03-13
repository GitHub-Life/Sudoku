//
//  IMGestureLockView.h
//  WalkBank
//
//  Created by 万涛 on 2019/1/11.
//  Copyright © 2019 shanhai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IMGestureLockSelectedStyle) {
    IMGestureLockSelectedStyleNone = 0,
    IMGestureLockSelectedStyleHighlight,
    IMGestureLockSelectedStyleConnectingLine
};

NS_ASSUME_NONNULL_BEGIN

@interface IMGestureLockView : UIView

@property (nonatomic, assign) IBInspectable CGFloat pointSize;

@property (nonatomic, copy) IBInspectable UIColor *pointColor;
@property (nonatomic, copy) IBInspectable UIColor *selectedColor;
@property (nonatomic, assign) IMGestureLockSelectedStyle selectedStyle;

- (void)clearSelected;

- (void)setResult:(void(^)(NSString *string))result;

@end

NS_ASSUME_NONNULL_END
