//
//  SLevelButton.m
//  Sudoku
//
//  Created by 万涛 on 2020/3/14.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import "SLevelButton.h"
#import "UIView+IB.h"

@implementation SLevelButton

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
    [self setTitleColor:UIColor.labelColor forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.cornerRadius = 7;
    self.borderColor = UIColor.labelColor;
    self.borderWidth = 1;
    self.contentEdgeInsets = UIEdgeInsetsMake(12, 24, 12, 24);
}

@end
