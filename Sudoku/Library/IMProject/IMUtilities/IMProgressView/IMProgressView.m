//
//  IMProgressView.m
//  ADWallet
//
//  Created by 万涛 on 2019/1/19.
//  Copyright © 2019 AiDian. All rights reserved.
//

#import "IMProgressView.h"

@implementation IMProgressView

- (instancetype)init {
    if (self = [super init]) {
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
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (!self.finishText.length && self.progress >= 1) return;
    
    CGFloat width_2 = CGRectGetWidth(rect) * 0.5;
    CGFloat height_2 = CGRectGetHeight(rect) * 0.5;
    CGPoint center = CGPointMake(width_2, height_2);

    [[UIColor colorWithWhite:0 alpha:0.3] setFill];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    if (self.finishText.length) {
        [path fill];
        UIFont *font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
        CGSize textSize = [self.finishText sizeWithAttributes:@{NSFontAttributeName : font}];
        [self.finishText drawAtPoint:CGPointMake(width_2 - textSize.width * 0.5, height_2 - textSize.height * 0.5) withAttributes:@{NSFontAttributeName : font, NSForegroundColorAttributeName : (self.progress==1 ? UIColor.whiteColor : UIColor.redColor)}];
    } else {
        [path moveToPoint:CGPointMake(width_2, height_2 - self.centerCircleRadius)];
        [path addArcWithCenter:center radius:self.centerCircleRadius startAngle:0 endAngle:2 * M_PI clockwise:YES];
        [path moveToPoint:center];
        [path addArcWithCenter:center radius:self.progressCircleRadius startAngle:-M_PI_2 endAngle:(-M_PI_2 - 2 * M_PI * (1 - self.progress)) clockwise:NO];
        path.usesEvenOddFillRule = YES;
        [path fill];
    }
}

- (void)setProgress:(CGFloat)progress {
    if (progress < 0) {
        progress = 0;
    } else if (progress > 1) {
        progress = 1;
    }
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)setFinishText:(NSString *)finishText {
    if (![_finishText isEqualToString:finishText]) {
        _finishText = finishText;
        [self setNeedsDisplay];
    }
}

#define Default
- (CGFloat)centerCircleRadius {
    if (_centerCircleRadius > 0) {
        return _centerCircleRadius;
    }
    return 20;
}

- (CGFloat)progressCircleRadius {
    if (_progressCircleRadius > 0) {
        return _progressCircleRadius;
    }
    return 17;
}

@end
