//
//  IMSudokuNumKeyboardView.h
//  Sudoku
//
//  Created by 万涛 on 2020/3/16.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMSudokuNumKeyButton.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IMSudokuNumKeyboardViewDelegate <NSObject>

- (void)clickNumKeyBtn:(IMSudokuNumKeyButton *)numKeyBtn;

@end

@interface IMSudokuNumKeyboardView : UIView

@property (nonatomic, weak, nullable) id delegate;

- (void)setQualifiedNums:(NSSet * _Nullable)qualifiedNums;

@end

NS_ASSUME_NONNULL_END
