//
//  SudokuViewController.m
//  Sudoku
//
//  Created by 万涛 on 2020/3/14.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import "SudokuViewController.h"
#import "SNumButton.h"
#import "SNumKeyButton.h"
#import "IMSudokuTool.h"

@interface SudokuViewController ()

@property (strong, nonatomic) IBOutletCollection(SNumButton) NSArray *items0;
@property (strong, nonatomic) IBOutletCollection(SNumButton) NSArray *items1;
@property (strong, nonatomic) IBOutletCollection(SNumButton) NSArray *items2;
@property (strong, nonatomic) IBOutletCollection(SNumButton) NSArray *items3;
@property (strong, nonatomic) IBOutletCollection(SNumButton) NSArray *items4;
@property (strong, nonatomic) IBOutletCollection(SNumButton) NSArray *items5;
@property (strong, nonatomic) IBOutletCollection(SNumButton) NSArray *items6;
@property (strong, nonatomic) IBOutletCollection(SNumButton) NSArray *items7;
@property (strong, nonatomic) IBOutletCollection(SNumButton) NSArray *items8;

@property (nonatomic, strong) NSArray<NSArray *> *itemsArray;
@property (nonatomic, weak) NSArray<NSArray *> *completeDatas;
@property (nonatomic, weak) NSArray<NSMutableArray *> *datas;
@property (nonatomic, strong) NSDictionary *sudokuDatas;
@property (nonatomic, weak) SNumButton *selectedItem;

@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (strong, nonatomic) IBOutletCollection(SNumKeyButton) NSArray *numKeyBtns;

@end

@implementation SudokuViewController

#pragma mark - 懒加载
- (NSArray<NSArray *> *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = @[_items0, _items1, _items2, _items3, _items4, _items5, _items6, _items7, _items8];
    }
    return _itemsArray;
}

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
    for (int i = 0; i < self.itemsArray.count; i++) {
        NSArray *items = self.itemsArray[i];
        for (int j = 0; j < items.count; j++) {
            UIButton *item = items[j];
            item.tag = i * 10 + j;
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
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
    for (int i = 0; i < MIN(self.itemsArray.count, self.datas.count); i++) {
        for (int j = 0; j < MIN(self.itemsArray[i].count, self.datas[i].count); j++) {
            SNumButton *item = self.itemsArray[i][j];
            item.num = self.datas[i][j];
            if ([item.num isEqualToString:@"0"]) {
                item.backgroundColor = UIColor.systemFillColor;
            }
        }
    }
}

- (void)numKeyshHighlightQualifiedNums {
    if (self.selectedItem == nil) {
        for (SNumKeyButton *numKeyBtn in self.numKeyBtns) {
            numKeyBtn.enabled = NO;
        }
    } else {
        NSArray<NSString *> *qualifiedNums = [IMSudoku qualifiedNumsWithDatas:self.datas row:self.selectedItem.row column:self.selectedItem.column];
        for (SNumKeyButton *numKeyBtn in self.numKeyBtns) {
            numKeyBtn.enabled = [qualifiedNums containsObject:numKeyBtn.num];
        }
    }
}

#pragma mark - 按钮点击事件
- (void)itemClick:(SNumButton *)item {
    self.selectedItem.selected = NO;
    item.selected = YES;
    self.selectedItem = item;
    [self numKeyshHighlightQualifiedNums];
}

- (void)numkeyClick:(SNumKeyButton *)numKey {
    if (self.selectedItem == nil) return;
    [self setItemNum:numKey.num];
}

- (IBAction)hintClick {
    if (self.selectedItem == nil) return;
    [self setItemNum:self.completeDatas[self.selectedItem.row][self.selectedItem.column]];
}

- (void)setItemNum:(NSString *)num {
    if (self.selectedItem == nil) return;
    self.selectedItem.num = num;
    self.datas[self.selectedItem.row][self.selectedItem.column] = self.selectedItem.num;
    [self numKeyshHighlightQualifiedNums];
    if (![IMSudoku verifySudokuWithDatas:self.datas row:self.selectedItem.row column:self.selectedItem.column]) {
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
    if (self.selectedItem == nil) return;
    self.selectedItem.num = @"";
    self.datas[self.selectedItem.row][self.selectedItem.column] = @"";
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
        if (weakSelf.selectedItem != nil) {
            weakSelf.selectedItem.selected = NO;
            weakSelf.selectedItem = nil;
            [weakSelf numKeyshHighlightQualifiedNums];
        }
    }];
    [alert addAction:cancel];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 页面即将消失
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IMSudokuTool saveSudokuDatas:self.sudokuDatas difficultyLevel:self.difficultyLevel];
}

@end
