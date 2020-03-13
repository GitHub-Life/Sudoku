//
//  UILabel+IB.m
//  Bullseye
//
//  Created by 万涛 on 2018/7/13.
//  Copyright © 2018年 niuyan.com. All rights reserved.
//

#import "UILabel+IB.h"

@implementation UILabel (IB)
@dynamic autoAdjWidth;

- (void)setAutoAdjWidth:(BOOL)autoAdjWidth {
    self.adjustsFontSizeToFitWidth = autoAdjWidth;
}

@end
