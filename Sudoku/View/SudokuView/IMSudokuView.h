//
//  IMSudokuView.h
//  Sudoku
//
//  Created by 万涛 on 2020/3/15.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMSudokuNumItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IMSudokuViewDelegate <NSObject>

- (void)sudokuNumItemSelected;

@end

@interface IMSudokuView : UIView

@property (nonatomic, strong) NSArray<NSArray<IMSudokuNumItem *> *> *numItemsArray;

@property (nonatomic, weak, nullable) id <IMSudokuViewDelegate> delegate;

@property (nonatomic, weak) IMSudokuNumItem *selectedItem;

@end

NS_ASSUME_NONNULL_END
