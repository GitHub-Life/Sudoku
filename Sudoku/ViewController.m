//
//  ViewController.m
//  Sudoku
//
//  Created by 万涛 on 2020/3/9.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import "ViewController.h"
#import "SNumButton.h"
#import "IMSudoku.h"
#import "SNumKeyButton.h"

@interface ViewController ()

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
@property (nonatomic, strong) NSArray<NSMutableArray *> *completeDatas;
@property (nonatomic, strong) NSArray<NSMutableArray *> *datas;
@property (nonatomic, strong) IMSudoku *sudoku;
@property (nonatomic, weak) SNumButton *selectedItem;

@property (strong, nonatomic) IBOutletCollection(SNumKeyButton) NSArray *numKeyBtns;
@property (weak, nonatomic) IBOutlet SNumKeyButton *deleteKeyBtn;

@end

@implementation ViewController

#pragma mark - 懒加载
- (NSArray<NSArray *> *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = @[_items0, _items1, _items2, _items3, _items4, _items5, _items6, _items7, _items8];
    }
    return _itemsArray;
}

- (NSArray<NSArray *> *)completeDatas {
    if (!_completeDatas) {
        _completeDatas = [self.sudoku generateCompleteSudokuDatas];
    }
    return _completeDatas;
}

- (NSArray<NSArray *> *)datas {
    if (!_datas) {
        _datas = self.completeDatas;
    }
    return _datas;
}

- (IMSudoku *)sudoku {
    if (!_sudoku) {
        _sudoku = [[IMSudoku alloc] init];
    }
    return _sudoku;
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
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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

#pragma mark - 按钮点击事件
- (void)itemClick:(SNumButton *)item {
    self.selectedItem.selected = NO;
    item.selected = YES;
    self.selectedItem = item;
}

- (void)numkeyClick:(SNumKeyButton *)numKey {
    if (self.selectedItem == nil) return;
    self.selectedItem.num = numKey.num;
    NSInteger row = self.selectedItem.tag / 10;
    NSInteger column = self.selectedItem.tag % 10;
    self.datas[row][column] = numKey.num;
}

- (IBAction)deleteClick:(UIButton *)sender {
    if (self.selectedItem == nil) return;
    self.selectedItem.num = @"";
    NSInteger row = self.selectedItem.tag / 10;
    NSInteger column = self.selectedItem.tag % 10;
    self.datas[row][column] = @"";
}

@end
