//
//  IMProgressView.h
//  ADWallet
//
//  Created by 万涛 on 2019/1/19.
//  Copyright © 2019 AiDian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMProgressView : UIView

@property (nonatomic, assign) IBInspectable CGFloat progress;

@property (nonatomic, copy, nullable) NSString *finishText;

@property (nonatomic, assign) IBInspectable CGFloat centerCircleRadius;
@property (nonatomic, assign) IBInspectable CGFloat progressCircleRadius;

@end

NS_ASSUME_NONNULL_END
