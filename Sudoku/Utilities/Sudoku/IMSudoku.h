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
- (BOOL)verifySudokuWithDatas:(NSArray<NSArray<NSString *> *> *)datas row:(NSInteger)row column:(NSInteger)column;

/// 生成数独数据
- (NSMutableArray<NSMutableArray<NSString *> *> *)generateCompleteSudokuDatas;

@end

NS_ASSUME_NONNULL_END
