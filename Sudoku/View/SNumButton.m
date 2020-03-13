//
//  SNumButton.m
//  Sudoku
//
//  Created by 万涛 on 2020/3/12.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import "SNumButton.h"
#import "UIView+IB.h"

@implementation SNumButton

- (instancetype)init {
    if (self = [super init]) {
        [self initSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self initSetup];
    }
    return self;
}

- (void)initSetup {
    self.backgroundColor = UIColor.systemBackgroundColor;
    self.tintColor = UIColor.clearColor;
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [self setTitleColor:UIColor.labelColor forState:UIControlStateNormal];
    [self setTitleColor:UIColor.labelColor forState:UIControlStateSelected];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
        self.backgroundColor = UIColor.systemBackgroundColor;
        [self setTitleColor:UIColor.labelColor forState:UIControlStateNormal];
    } else {
        self.backgroundColor = UIColor.systemFillColor;
        [self setTitleColor:[UIColor.labelColor colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
    }
}

- (void)setNum:(NSString *)num {
    _num = num;
    if ([num isEqual:@"0"]) {
        [self setTitle:@"" forState:UIControlStateNormal];
    } else {
        [self setTitle:num forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.borderColor = UIColor.systemTealColor;
        self.borderWidth = 1;
    } else {
        self.borderWidth = 0;
    }
}

@end
