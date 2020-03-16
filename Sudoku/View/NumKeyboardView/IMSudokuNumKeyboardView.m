//
//  IMSudokuNumKeyboardView.m
//  Sudoku
//
//  Created by 万涛 on 2020/3/16.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import "IMSudokuNumKeyboardView.h"
#import <Masonry.h>

@interface IMSudokuNumKeyboardView ()

@property (nonatomic, strong) NSArray<IMSudokuNumKeyButton *> *numKeyBtnArray;

@end

@implementation IMSudokuNumKeyboardView

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
    UIStackView *keybardContarinerView = [[UIStackView alloc] init];
    keybardContarinerView.axis = UILayoutConstraintAxisVertical;
    keybardContarinerView.distribution = UIStackViewDistributionFillEqually;
    keybardContarinerView.spacing = 1;
    NSMutableArray *numKeyBtns = [NSMutableArray arrayWithCapacity:9];
    for (int i = 0; i < 3; i++) {
        UIStackView *rowContainerView = [[UIStackView alloc] init];
        rowContainerView.axis = UILayoutConstraintAxisHorizontal;
        rowContainerView.distribution = UIStackViewDistributionFillEqually;
        rowContainerView.spacing = 1;
        for (int j = 0; j < 3; j++) {
            IMSudokuNumKeyButton *numKeyBtn = [[IMSudokuNumKeyButton alloc] init];
            numKeyBtn.tag = i * 3 + j + 1;
            [numKeyBtn setTitle:[NSString stringWithFormat:@"%d", (int)numKeyBtn.tag] forState:UIControlStateNormal];
            [numKeyBtn addTarget:self action:@selector(numKeyBtmClick:) forControlEvents:UIControlEventTouchUpInside];
            [numKeyBtns addObject:numKeyBtn];
            [rowContainerView addArrangedSubview:numKeyBtn];
        }
        [keybardContarinerView addArrangedSubview:rowContainerView];
    }
    _numKeyBtnArray = numKeyBtns.copy;
    [self addSubview:keybardContarinerView];
    [keybardContarinerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(1);
        make.leading.mas_equalTo(1);
        make.trailing.mas_equalTo(-1);
        make.bottom.mas_equalTo(-1);
    }];
}

- (void)numKeyBtmClick:(IMSudokuNumKeyButton *)numKeyBtn {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(clickNumKeyBtn:)]) {
        [self.delegate clickNumKeyBtn:numKeyBtn];
    }
}

- (void)setQualifiedNums:(NSSet *)qualifiedNums {
    for (IMSudokuNumKeyButton *numKeyBtn in self.numKeyBtnArray) {
        numKeyBtn.enabled = (qualifiedNums != nil && [qualifiedNums containsObject:numKeyBtn.num]);
    }
}

@end
