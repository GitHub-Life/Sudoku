//
//  IMSudoku.h
//  SudokuTest
//
//  Created by 万涛 on 2020/3/12.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMSudoku : NSObject


/// 验证某个点的数字是否符合数独规则
/// @param datas 数独数据
/// @param row 某个点的横坐标
/// @param column 某个点的纵坐标
+ (BOOL)verifySudokuWithDatas:(NSArray<NSArray<NSString *> *> *)datas row:(NSInteger)row column:(NSInteger)column;


/// 生成终盘数独数据
+ (NSMutableArray<NSMutableArray<NSString *> *> *)generateCompleteSudokuDatas;

/// 根据终盘数独数据生成可解的数独数据
/// @param completeDatas 终盘数独数据
+ (NSMutableArray<NSMutableArray<NSString *> *> *)generateSudokuDatasWithCompleteSudokuDatas:(NSArray<NSArray<NSString *> *> *)completeDatas;


/// 某个点可以填入的符合数独规则的数字集合
/// @param datas 数独数据
/// @param row 某个点的横坐标
/// @param column 某个点的纵坐标
+ (NSSet<NSString *> *)qualifiedNumsWithDatas:(NSArray<NSArray<NSString *> *> *)datas row:(NSInteger)row column:(NSInteger)column;

@end

NS_ASSUME_NONNULL_END
