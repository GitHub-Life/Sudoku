//
//  IMSudokuTool.h
//  Sudoku
//
//  Created by 万涛 on 2020/3/14.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMSudoku.h"

NS_ASSUME_NONNULL_BEGIN

static const NSString *COMPLETE_SUDOKU_DATAS_KEY = @"complete_sudoku_datas_key";
static const NSString *SUDOKU_DATAS_KEY = @"sudoku_datas_key";

@interface IMSudokuTool : NSObject


/// 存储数独数据
/// @param sudokuDatas 数独数据
/// @param level 难度等级
+ (void)saveSudokuDatas:(NSDictionary *)sudokuDatas difficultyLevel:(int)level;


/// 获取不同难度对应的数独数据
/// @param level 难度等级
+ (NSDictionary *)sudokuDatasWithDifficultyLevel:(int)level;


/// 清除不同难度对应的数独数据
/// @param level 难度等级
+ (void)clearSudokuDatasWithDifficultyLevel:(int)level;


/// 判断是否正确完成
/// @param sudokuDatas 数独数据(包含终盘数据与待解数据)
+ (BOOL)judgeCorrectCompletionWithSudokuDatas:(NSDictionary *)sudokuDatas;

@end

NS_ASSUME_NONNULL_END
