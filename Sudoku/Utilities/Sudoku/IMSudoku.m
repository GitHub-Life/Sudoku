//
//  IMSudoku.m
//  SudokuTest
//
//  Created by 万涛 on 2020/3/12.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import "IMSudoku.h"

@implementation IMSudoku

/// 验证某个点的数字是否符合数独规则
/// @param datas 数独数据
/// @param row 某个点的横坐标
/// @param column 某个点的纵坐标
- (BOOL)verifySudokuWithDatas:(NSArray<NSArray<NSString *> *> *)datas row:(NSInteger)row column:(NSInteger)column {
    if (row >= datas.count) {
        return NO;
    }
    NSArray<NSString *> *rowNums = datas[row];
    if (column >= rowNums.count) {
        return NO;
    }
    NSString *numStr = rowNums[column];
    if ([numStr isEqualToString:@"0"] || [numStr isEqualToString:@""]) {
        return NO;
    }
    // 横向验证
    for (int i = 0; i < rowNums.count; i++) {
        if (i != column && [numStr isEqualToString:rowNums[i]]) {
            return NO;
        }
    }
    // 纵向验证
    for (int i = 0; i < datas.count; i++) {
        if (column >= datas[i].count) {
            return NO;
        }
        if (i != row && [numStr isEqualToString:datas[i][column]]) {
            return NO;
        }
    }
    // 3*3单元验证
    NSInteger startRow = row - row % 3;
    NSInteger startColumn = column = column % 3;
    for (NSInteger i = startRow; i < startRow + 3; i++) {
        for (NSInteger j = startColumn; j < startColumn + 3; j++) {
            if (i != row && j != column && [numStr isEqualToString:datas[i][j]]) {
                return NO;
            }
        }
    }
    return YES;
}

/// 生成空数独数据(数据全为0)
- (NSMutableArray<NSMutableArray<NSString *> *> *)generateZeroSudokuDatas {
    NSMutableArray<NSMutableArray<NSString *> *> *datas = [NSMutableArray arrayWithCapacity:9];
    for (int i = 0; i < 9; i++) {
        NSMutableArray<NSString *> *rowNums = [NSMutableArray arrayWithCapacity:9];
        for (int j = 0; j < 9; j++) {
            [rowNums addObject:@"0"];
        }
        [datas addObject:rowNums];
    }
    return datas;
}

/// 生成初始数独数据
- (NSMutableArray<NSMutableArray<NSString *> *> *)generateInitialSudokuDatas {
    NSMutableArray<NSMutableArray<NSString *> *> *datas = [self generateZeroSudokuDatas];
    // 1.按顺序将 1~9 填入宫格中；
    // 2.检查所在行、列及3*3单元中是否存在相同数字；
    // 3.若存在相同数字则将数字加1，重复第2步
    int num = arc4random() % 9 + 1;
    for (int i = 0; i < datas.count; i++) {
        for (int j = 0; j < datas[i].count; j++) {
            datas[i][j] = [NSString stringWithFormat:@"%d", num];
            num++;
            if (num > 9) {
                num = 1;
            }
            if (![self verifySudokuWithDatas:datas row:i column:j]) {
                j--;
            }
        }
    }
    return datas;
}


/// 将初始数独数据变换
/// @param datas 初始数独数据
- (NSMutableArray<NSMutableArray<NSString *> *> *)conversionSudokuDatas:(NSMutableArray<NSMutableArray<NSString *> *> *)datas {
    // 随机交换某两行(同一个3*3单元内)
    int row = 1;
    while (row < 9 && row % 3 == 1) {
        NSMutableArray<NSString *> *tempNums = datas[row];
        int conversionRow = row;
        if (arc4random() % 2 == 0) {
            conversionRow--;
        } else {
            conversionRow++;
        }
        datas[row] = datas[conversionRow];
        datas[conversionRow] = tempNums;
        row += 3;
    }
    // 随机交换某两列(同一个3*3单元内)
    int column = 1;
    while (column < 9 && column % 3 == 1) {
        NSMutableArray<NSString *> *tempNums = [NSMutableArray arrayWithCapacity:9];
        for (NSMutableArray<NSString *> *rowNums in datas) {
            [tempNums addObject:rowNums[column]];
        }
        int conversionColumn = column;
        if (arc4random() % 2 == 0) {
            conversionColumn--;
        } else {
            conversionColumn++;
        }
        for (NSMutableArray<NSString *> *rowNums in datas) {
            rowNums[column] = rowNums[conversionColumn];
        }
        for (int i = 0; i < datas.count; i++) {
            datas[i][conversionColumn] = tempNums[i];
        }
        
        column += 3;
    }
    
    return datas;
}

/// 生成数独数据
- (NSMutableArray<NSMutableArray<NSString *> *> *)generateCompleteSudokuDatas {
    return [self conversionSudokuDatas:[self generateInitialSudokuDatas]];
}

@end
