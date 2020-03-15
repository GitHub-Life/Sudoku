//
//  IMSudokuView.m
//  Sudoku
//
//  Created by 万涛 on 2020/3/15.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import "IMSudokuView.h"
#import <Masonry.h>

@implementation IMSudokuView

- (instancetype)init {
    if (self = [super init]) {
        [self initSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self initSetup];
    }
    return self;
}

- (void)initSetup {
    self.backgroundColor = UIColor.separatorColor;
    NSMutableArray<NSMutableArray<IMSudokuNumItem *> *> *numItemsArray = [NSMutableArray arrayWithCapacity:9];
    for (int i = 0; i < 9; i++) {
        NSMutableArray<IMSudokuNumItem *> *rowItems = [NSMutableArray arrayWithCapacity:9];
        [numItemsArray addObject:rowItems];
    }
    UIStackView *sudokuContarinerView = [[UIStackView alloc] init];
    sudokuContarinerView.axis = UILayoutConstraintAxisVertical;
    sudokuContarinerView.distribution = UIStackViewDistributionFillEqually;
    sudokuContarinerView.spacing = 3;
    for (int i = 0; i < 3; i++) {
        UIStackView *largeRowContainerView = [[UIStackView alloc] init];
        largeRowContainerView.axis = UILayoutConstraintAxisHorizontal;
        largeRowContainerView.distribution = UIStackViewDistributionFillEqually;
        largeRowContainerView.spacing = 3;
        for (int j = 0; j < 3; j++) {
            UIStackView *littleSudokuContainerView = [[UIStackView alloc] init];
            littleSudokuContainerView.axis = UILayoutConstraintAxisVertical;
            littleSudokuContainerView.distribution = UIStackViewDistributionFillEqually;
            littleSudokuContainerView.spacing = 0.5;
            for (int k = 0; k < 3; k++) {
                UIStackView *rowContainerView = [[UIStackView alloc] init];
                rowContainerView.axis = UILayoutConstraintAxisHorizontal;
                rowContainerView.distribution = UIStackViewDistributionFillEqually;
                rowContainerView.spacing = 0.5;
                for (int l = 0; l < 3; l++) {
                    IMSudokuNumItem *numItem = [[IMSudokuNumItem alloc] init];
                    numItem.tag = (i * 3 + k) * 10 + (j * 3 + l);
                    [numItemsArray[i * 3 + k] addObject:numItem];
                    [rowContainerView addArrangedSubview:numItem];
                    [numItem addTarget:self action:@selector(numItemClick:) forControlEvents:UIControlEventTouchUpInside];
                }
                [littleSudokuContainerView addArrangedSubview:rowContainerView];
            }
            [largeRowContainerView addArrangedSubview:littleSudokuContainerView];
        }
        [sudokuContarinerView addArrangedSubview:largeRowContainerView];
    }
    _numItemsArray = numItemsArray.copy;
    [self addSubview:sudokuContarinerView];
    [sudokuContarinerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(3);
        make.leading.mas_equalTo(3);
        make.trailing.mas_equalTo(-3);
        make.bottom.mas_equalTo(-3);
    }];
}

- (void)numItemClick:(IMSudokuNumItem *)item {
    if (self.selectedItem != nil) {
        self.selectedItem.selected = NO;
    }
    item.selected = YES;
    self.selectedItem = item;
    if (self.delegate && [self.delegate respondsToSelector:@selector(sudokuNumItemSelected)]) {
        [self.delegate sudokuNumItemSelected];
    }
}

@end
