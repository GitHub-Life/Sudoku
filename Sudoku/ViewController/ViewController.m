//
//  ViewController.m
//  Sudoku
//
//  Created by 万涛 on 2020/3/9.
//  Copyright © 2020 iMoon. All rights reserved.
//

#import "ViewController.h"
#import "SudokuViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *difficultyLevelBtns;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSetup];
}

- (void)initSetup {
    for (int i = 0; i < self.difficultyLevelBtns.count; i++) {
        UIButton *levelBtn = self.difficultyLevelBtns[i];
        levelBtn.tag = i + 1;
        [levelBtn addTarget:self action:@selector(levelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)levelBtnClick:(UIButton *)levelBtn {
    SudokuViewController *sudokuVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SudokuViewController"];
    sudokuVC.difficultyLevel = (int)levelBtn.tag;
    sudokuVC.title = [levelBtn titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:sudokuVC animated:YES];
}

@end
