//
//  SudokuViewController.m
//  Sudoku
//
//  Created by 万涛 on 2020/3/14.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import "SudokuViewController.h"
#import "IMSudokuView.h"
#import "SNumKeyButton.h"
#import "IMSudokuTool.h"

@interface SudokuViewController () <IMSudokuViewDelegate>

@property (weak, nonatomic) IBOutlet IMSudokuView *sudokuView;
@property (nonatomic, weak) NSArray<NSArray *> *completeDatas;
@property (nonatomic, weak) NSArray<NSMutableArray *> *datas;
@property (nonatomic, strong) NSDictionary *sudokuDatas;

@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (strong, nonatomic) IBOutletCollection(SNumKeyButton) NSArray *numKeyBtns;
@property (weak, nonatomic) IBOutlet UIButton *noteBtn;

@end

@implementation SudokuViewController

#pragma mark - 懒加载
- (NSDictionary *)sudokuDatas {
    if (!_sudokuDatas) {
        _sudokuDatas = [IMSudokuTool sudokuDatasWithDifficultyLevel:self.difficultyLevel];
    }
    return _sudokuDatas;
}

- (NSArray<NSArray *> *)completeDatas {
    if (!_completeDatas) {
        _completeDatas = self.sudokuDatas[COMPLETE_SUDOKU_DATAS_KEY];
    }
    return _completeDatas;
}

- (NSArray<NSMutableArray *> *)datas {
    if (!_datas) {
        _datas = self.sudokuDatas[SUDOKU_DATAS_KEY];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSetup];
}

- (void)initSetup {
    self.sudokuView.delegate = self;
    for (int i = 0; i < self.numKeyBtns.count; i++) {
        UIButton *numKey = self.numKeyBtns[i];
        numKey.tag = i + 1;
        [numKey addTarget:self action:@selector(numkeyClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self numKeyshHighlightQualifiedNums];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self fillDatas];
}

- (void)fillDatas {
    for (int i = 0; i < MIN(self.sudokuView.numItemsArray.count, self.datas.count); i++) {
        for (int j = 0; j < MIN(self.sudokuView.numItemsArray[i].count, self.datas[i].count); j++) {
            IMSudokuNumItem *item = self.sudokuView.numItemsArray[i][j];
            item.num = self.datas[i][j];
            if ([item.num isEqualToString:@"0"]) {
                item.backgroundColor = UIColor.systemFillColor;
            }
        }
    }
}

#pragma mark - IMSudokuView Delagate
- (void)sudokuNumItemSelected {
    [self numKeyshHighlightQualifiedNums];
}


- (void)numKeyshHighlightQualifiedNums {
    if (self.sudokuView.selectedItem == nil) {
        for (SNumKeyButton *numKeyBtn in self.numKeyBtns) {
            numKeyBtn.enabled = NO;
        }
    } else {
        NSArray<NSString *> *qualifiedNums = [IMSudoku qualifiedNumsWithDatas:self.datas row:self.sudokuView.selectedItem.row column:self.sudokuView.selectedItem.column];
        for (SNumKeyButton *numKeyBtn in self.numKeyBtns) {
            numKeyBtn.enabled = [qualifiedNums containsObject:numKeyBtn.num];
        }
    }
}

#pragma mark - 按钮点击事件
- (void)numkeyClick:(SNumKeyButton *)numKey {
    if (self.sudokuView.selectedItem == nil) return;
    [self setItemNum:numKey.num];
}

- (IBAction)hintClick {
    if (self.sudokuView.selectedItem == nil) return;
    [self setItemNum:self.completeDatas[self.sudokuView.selectedItem.row][self.sudokuView.selectedItem.column]];
}

- (void)setItemNum:(NSString *)num {
    if (self.sudokuView.selectedItem == nil) return;
    self.sudokuView.selectedItem.num = num;
    self.datas[self.sudokuView.selectedItem.row][self.sudokuView.selectedItem.column] = self.sudokuView.selectedItem.num;
    [self numKeyshHighlightQualifiedNums];
    if (![IMSudoku verifySudokuWithDatas:self.datas row:self.sudokuView.selectedItem.row column:self.sudokuView.selectedItem.column]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.warningLabel.alpha = 1;
        }];
    } else {
        if ([IMSudokuTool judgeCorrectCompletionWithSudokuDatas:self.sudokuDatas]) {
            self.warningLabel.alpha = 1;
            self.warningLabel.text = @"恭喜您，已成功解出此数独！！！";
            self.view.userInteractionEnabled = NO;
        } else if (self.warningLabel.alpha != 0) {
            [UIView animateWithDuration:0.3 animations:^{
                self.warningLabel.alpha = 0;
            }];
        }
    }
}

- (IBAction)deleteClick {
    if (self.sudokuView.selectedItem == nil) return;
    self.sudokuView.selectedItem.num = @"";
    self.datas[self.sudokuView.selectedItem.row][self.sudokuView.selectedItem.column] = @"";
    [self numKeyshHighlightQualifiedNums];
}

- (IBAction)refreshClick {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更新数独盘" message:@"确定更新当前数独盘" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [IMSudokuTool clearSudokuDatasWithDifficultyLevel:weakSelf.difficultyLevel];
        weakSelf.sudokuDatas = nil;
        weakSelf.completeDatas = nil;
        weakSelf.datas = nil;
        [weakSelf fillDatas];
        if (weakSelf.sudokuView.selectedItem != nil) {
            weakSelf.sudokuView.selectedItem.selected = NO;
            weakSelf.sudokuView.selectedItem = nil;
            [weakSelf numKeyshHighlightQualifiedNums];
        }
    }];
    [alert addAction:cancel];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)noteClick {
}

#pragma mark - 页面即将消失
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IMSudokuTool saveSudokuDatas:self.sudokuDatas difficultyLevel:self.difficultyLevel];
}

@end
