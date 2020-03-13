//
//  IMGestureLockView.m
//  WalkBank
//
//  Created by 万涛 on 2019/1/11.
//  Copyright © 2019 shanhai. All rights reserved.
//

#import "IMGestureLockView.h"

@interface IMGesturePoint : NSObject

@property (nonatomic, assign, readonly) CGPoint center;
@property (nonatomic, assign) CGRect frame;
+ (instancetype)pointWithFrame:(CGRect)frame;

@property (nonatomic, copy) NSString *tag;

@end

@implementation IMGesturePoint

+ (instancetype)pointWithFrame:(CGRect)frame {
    IMGesturePoint *point = [[IMGesturePoint alloc] init];
    point.frame = frame;
    return point;
}

- (CGPoint)center {
    return CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
}

@end

@interface IMGestureLockView ()

@property (nonatomic, strong) void(^resultBlock)(NSString *string);

@property (nonatomic, strong) NSArray<IMGesturePoint *> *pointArray;

@property (nonatomic, strong) NSMutableArray<IMGesturePoint *> *selectedPointArray;

@property (nonatomic, assign) CGPoint movedPoint;

@end

@implementation IMGestureLockView

- (instancetype)init {
    if (self = [super init]) {
        [self initSettings];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSettings];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initSettings];
    }
    return self;
}

- (void)initSettings {
    self.backgroundColor = UIColor.clearColor;
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.shadowRadius = 7;
}

- (void)setResult:(void (^)(NSString * _Nonnull))result {
    _resultBlock = result;
}

- (NSMutableArray<IMGesturePoint *> *)selectedPointArray {
    if (!_selectedPointArray) {
        _selectedPointArray = [NSMutableArray arrayWithCapacity:self.pointArray.count];
    }
    return _selectedPointArray;
}

- (void)drawRect:(CGRect)rect {
    if (!self.pointArray.count) {
        [self createPointArrayWithRect:rect];
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (IMGesturePoint *point in self.pointArray) {
        CGContextMoveToPoint(context, point.center.x, point.center.y);
        if (self.selectedStyle == IMGestureLockSelectedStyleNone) {
            CGContextSetFillColorWithColor(context, self.pointColor.CGColor);
        } else {
            if ([self.selectedPointArray containsObject:point]) {
                CGContextSetFillColorWithColor(context, [self.selectedPointArray containsObject:point] ? [self.selectedColor colorWithAlphaComponent:0.3].CGColor : self.pointColor.CGColor);
                CGContextAddArc(context, point.center.x, point.center.y, self.pointSize * 0.5, 0, 2 * M_PI, 0);
                CGContextFillPath(context);
                CGContextSetFillColorWithColor(context, self.selectedColor.CGColor);
            } else {
                CGContextSetFillColorWithColor(context, self.pointColor.CGColor);
            }
        }
        CGContextAddArc(context, point.center.x, point.center.y, self.pointSize * 0.15, 0, 2 * M_PI, 0);
        CGContextFillPath(context);
    }
    if (self.selectedStyle == IMGestureLockSelectedStyleConnectingLine && self.selectedPointArray.count) {
        CGContextSetLineWidth(context, 3);
        CGContextSetStrokeColorWithColor(context, self.selectedColor.CGColor);
        CGContextMoveToPoint(context, self.selectedPointArray.firstObject.center.x, self.selectedPointArray.firstObject.center.y);
        for (int i = 1; i < self.selectedPointArray.count; i++) {
            CGContextAddLineToPoint(context, self.selectedPointArray[i].center.x, self.selectedPointArray[i].center.y);
        }
        if (!CGPointEqualToPoint(CGPointZero, self.movedPoint)) {
            CGContextAddLineToPoint(context, self.movedPoint.x, self.movedPoint.y);
        }
        CGContextStrokePath(context);
    }
}

- (void)createPointArrayWithRect:(CGRect)rect {
    CGFloat width_2 = CGRectGetWidth(rect) * 0.5;
    CGFloat height_2 = CGRectGetHeight(rect) * 0.5;
    CGFloat pointRadius = self.pointSize * 0.5;
    NSMutableArray<IMGesturePoint *> *pointArray = [NSMutableArray arrayWithCapacity:9];
    [pointArray addObject:[IMGesturePoint pointWithFrame:CGRectMake(0, 0, self.pointSize, self.pointSize)]];
    [pointArray addObject:[IMGesturePoint pointWithFrame:CGRectMake(width_2 - pointRadius, 0, self.pointSize, self.pointSize)]];
    [pointArray addObject:[IMGesturePoint pointWithFrame:CGRectMake(width_2 * 2 - self.pointSize, 0, self.pointSize, self.pointSize)]];
    [pointArray addObject:[IMGesturePoint pointWithFrame:CGRectMake(0, height_2 - pointRadius, self.pointSize, self.pointSize)]];
    [pointArray addObject:[IMGesturePoint pointWithFrame:CGRectMake(width_2 - pointRadius, height_2 - pointRadius, self.pointSize, self.pointSize)]];
    [pointArray addObject:[IMGesturePoint pointWithFrame:CGRectMake(width_2 * 2 - self.pointSize, height_2 - pointRadius, self.pointSize, self.pointSize)]];
    [pointArray addObject:[IMGesturePoint pointWithFrame:CGRectMake(0, height_2 * 2 - self.pointSize, self.pointSize, self.pointSize)]];
    [pointArray addObject:[IMGesturePoint pointWithFrame:CGRectMake(width_2 - pointRadius, height_2 * 2  - self.pointSize, self.pointSize, self.pointSize)]];
    [pointArray addObject:[IMGesturePoint pointWithFrame:CGRectMake(width_2 * 2 - self.pointSize, height_2 * 2  - self.pointSize, self.pointSize, self.pointSize)]];
    [pointArray enumerateObjectsUsingBlock:^(IMGesturePoint *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tag = [NSString stringWithFormat:@"%d", (int)idx];
    }];
    self.pointArray = pointArray.copy;
}

#pragma mark - Default Value
- (CGFloat)pointSize {
    return _pointSize <= 0 ? 50 : _pointSize;
}

- (UIColor *)pointColor {
    return _pointColor ?: UIColor.whiteColor;
}

- (UIColor *)selectedColor {
    return _selectedColor ?: UIColor.greenColor;
}

#pragma mark - Gesture
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    for (IMGesturePoint *point in self.pointArray) {
        if (![self.selectedPointArray containsObject:point] && CGRectContainsPoint(point.frame, touchPoint)) {
            [self.selectedPointArray addObject:point];
            [self setNeedsDisplay];
            break;
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    for (IMGesturePoint *point in self.pointArray) {
        if (![self.selectedPointArray containsObject:point] && CGRectContainsPoint(point.frame, touchPoint)) {
            [self.selectedPointArray addObject:point];
            break;
        }
    }
    self.movedPoint = touchPoint;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    for (IMGesturePoint *point in self.pointArray) {
        if (![self.selectedPointArray containsObject:point] && CGRectContainsPoint(point.frame, touchPoint)) {
            [self.selectedPointArray addObject:point];
            [self setNeedsDisplay];
            break;
        }
    }
    NSMutableString *mutableStr = [NSMutableString string];
    [self.selectedPointArray enumerateObjectsUsingBlock:^(IMGesturePoint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mutableStr appendString:obj.tag];
    }];
    if (self.resultBlock) {
        self.resultBlock(mutableStr.copy);
    } else {
        [self clearSelected];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self clearSelected];
}

#pragma mark - 清除选中效果
- (void)clearSelected {
    [self.selectedPointArray removeAllObjects];
    self.movedPoint = CGPointZero;
    [self setNeedsDisplay];
}

@end
