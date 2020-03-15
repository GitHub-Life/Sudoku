//
//  IMSudokuNumItem.h
//  Sudoku
//
//  Created by 万涛 on 2020/3/12.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMSudokuNumItem : UIButton

@property (nonatomic, strong) NSString *num;

@property (nonatomic, assign) int errorLevel;

@property (nonatomic, readonly) NSInteger row;

@property (nonatomic, readonly) NSInteger column;

@property (nonatomic, strong) NSMutableSet<NSString *> *noteNums;

@end

NS_ASSUME_NONNULL_END
