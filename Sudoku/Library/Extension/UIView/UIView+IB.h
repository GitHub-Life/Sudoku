//
//  UIView+IB.h
//  NiuYan
//
//  Created by jarze on 2018/3/12.
//  Copyright © 2018年 niuyan.com. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIView (IB)

@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, copy) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

@property (nonatomic, assign) IBInspectable CGFloat shadowOpacity;
@property (nonatomic, assign) IBInspectable CGFloat shadowRadius;
@property (nonatomic, assign) IBInspectable CGSize shadowOffset;
@property (nonatomic, copy) IBInspectable UIColor *shadowColor;

@end
