//
//  IMSudokuNumItem.m
//  Sudoku
//
//  Created by 万涛 on 2020/3/12.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import "IMSudokuNumItem.h"
#import "UIView+IB.h"

@implementation IMSudokuNumItem

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
    self.tintColor = UIColor.clearColor;
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [self setTitleColor:UIColor.labelColor forState:UIControlStateNormal];
    [self setTitleColor:[UIColor.labelColor colorWithAlphaComponent:0.5] forState:UIControlStateDisabled];
    self.selected = NO;
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
        self.backgroundColor = UIColor.systemBackgroundColor;
    } else {
        self.backgroundColor = UIColor.separatorColor;
    }
}

- (void)setNum:(NSString *)num {
    _num = num;
    if ([num isEqual:@"0"] || num.length == 0) {
        [self setTitle:@"" forState:UIControlStateNormal];
    } else {
        [self setTitle:num forState:UIControlStateNormal];
        self.noteNums = [NSMutableSet set];;
        [self setNeedsDisplay];
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = UIColor.labelColor;
        [self setTitleColor:UIColor.systemBackgroundColor forState:UIControlStateSelected];
    } else {
        self.backgroundColor = UIColor.systemBackgroundColor;
        [self setTitleColor:UIColor.labelColor forState:UIControlStateSelected];
    }
}

- (void)setErrorLevel:(int)errorLevel {
    _errorLevel = errorLevel;
    UIColor *titleColor = UIColor.labelColor;
    if (errorLevel > 2) {
        titleColor = UIColor.redColor;
    } else if (errorLevel > 1) {
        titleColor = UIColor.orangeColor;
    } else if (errorLevel > 0) {
        titleColor = UIColor.yellowColor;
    }
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateSelected];
}

- (NSInteger)row {
    return (int)self.tag / 10;
}

- (NSInteger)column {
    return (int)self.tag % 10;
}

- (void)setNoteNums:(NSMutableSet<NSString *> *)noteNums {
    _noteNums = noteNums;
    [self setNeedsDisplay];
}

- (void)addNoteNum:(NSString *)noteNum {
    if (self.titleLabel.text.length > 0) {
        self.num = @"";
    }
    if (_noteNums == nil) {
        [_noteNums addObject:noteNum];
        [self setNeedsDisplay];
    } else if (![_noteNums containsObject:noteNum]) {
        [_noteNums addObject:noteNum];
        [self setNeedsDisplay];
    }
}

- (void)removeNoteNum:(NSString *)noteNum {
    if ([_noteNums containsObject:noteNum]) {
        [_noteNums removeObject:noteNum];
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_noteNums == nil || _noteNums.count == 0) {
        return;
    }
    CGFloat width_3 = CGRectGetWidth(rect) / 3;
    CGFloat height_3 = CGRectGetHeight(rect) / 3;
    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:width_3], NSForegroundColorAttributeName : UIColor.opaqueSeparatorColor};
    for (NSString *numStr in _noteNums) {
        int num = numStr.intValue;
        int row = (num - 1) / 3;
        int column = (num - 1) % 3;
        CGRect numRect = [numStr boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
        CGFloat x = column * width_3 + (width_3 - CGRectGetWidth(numRect)) / 2;
        CGFloat y = row * height_3 + (height_3 - CGRectGetHeight(numRect)) / 2;
        [numStr drawAtPoint:CGPointMake(x, y) withAttributes:attr];
    }
}

@end
