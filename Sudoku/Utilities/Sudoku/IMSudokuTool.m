//
//  IMSudokuTool.m
//  Sudoku
//
//  Created by 万涛 on 2020/3/14.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import "IMSudokuTool.h"
#import <MJExtension.h>

@implementation IMSudokuTool


/// 存储数独数据
/// @param sudokuDatas 数独数据
/// @param level 难度等级
+ (void)saveSudokuDatas:(NSDictionary *)sudokuDatas difficultyLevel:(int)level {
    NSString *str = sudokuDatas.mj_JSONString;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:str forKey:[NSString stringWithFormat:@"%d", level]];
    [userDefaults synchronize];
}


/// 获取不同难度对应的数独数据
/// @param level 难度等级
+ (NSDictionary *)sudokuDatasWithDifficultyLevel:(int)level {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *str = [userDefaults stringForKey:[NSString stringWithFormat:@"%d", level]];
    if (str != nil) {
        NSMutableDictionary *dict = ((NSDictionary *)str.mj_JSONObject).mutableCopy;
        NSMutableArray *completeDatas = [NSMutableArray array];
        for (NSArray *rowNums in dict[COMPLETE_SUDOKU_DATAS_KEY]) {
            [completeDatas addObject:rowNums.mutableCopy];
        }
        NSMutableArray *datas = [NSMutableArray array];
        for (NSArray *rowNums in dict[SUDOKU_DATAS_KEY]) {
            [datas addObject:rowNums.mutableCopy];
        }
        dict[COMPLETE_SUDOKU_DATAS_KEY] = completeDatas;
        dict[SUDOKU_DATAS_KEY] = datas;
        return dict;
    } else {
        NSArray *completeDatas = [IMSudoku generateCompleteSudokuDatas];
        NSArray *datas = [IMSudoku generateSudokuDatasWithCompleteSudokuDatas:completeDatas];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[COMPLETE_SUDOKU_DATAS_KEY] = completeDatas;
        dict[SUDOKU_DATAS_KEY] = datas;
        [self saveSudokuDatas:dict difficultyLevel:level];
        return dict.copy;
    }
}


/// 清除不同难度对应的数独数据
/// @param level 难度等级
+ (void)clearSudokuDatasWithDifficultyLevel:(int)level {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:[NSString stringWithFormat:@"%d", level]];
}


/// 判断是否正确完成
/// @param sudokuDatas 数独数据(包含终盘数据与待解数据)
+ (BOOL)judgeCorrectCompletionWithSudokuDatas:(NSDictionary *)sudokuDatas {
    NSArray *completeDatas = sudokuDatas[COMPLETE_SUDOKU_DATAS_KEY];
    NSArray *datas = sudokuDatas[SUDOKU_DATAS_KEY];
    if (completeDatas.count != datas.count) {
        return NO;
    }
    for (int i = 0; i < completeDatas.count; i++) {
        NSArray *completeRowNums = completeDatas[i];
        NSArray *rowNums = datas[i];
        if (completeRowNums.count != rowNums.count) {
            return NO;
        }
        for (int j = 0; j < completeRowNums.count; j++) {
            NSString *completeNum = completeRowNums[j];
            NSString *num = rowNums[j];
            if (![completeNum isEqualToString:num]) {
                return NO;
            }
        }
    }
    return YES;
}

@end
