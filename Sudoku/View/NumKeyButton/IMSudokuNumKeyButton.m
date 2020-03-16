//
//  IMSudokuNumKeyButton.m
//  Sudoku
//
//  Created by 万涛 on 2020/3/13.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import "IMSudokuNumKeyButton.h"
#import "UIView+IB.h"

@implementation IMSudokuNumKeyButton

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
    self.titleLabel.font = [UIFont systemFontOfSize:30];
    [self setTitleColor:UIColor.labelColor forState:UIControlStateNormal];
    [self setTitleColor:[UIColor.labelColor colorWithAlphaComponent:0.3] forState:UIControlStateDisabled];
}

- (NSString *)num {
    return self.titleLabel.text;
}

@end
