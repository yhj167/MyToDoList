//
//  YHJAddToDoItemViewController.m
//  ToDoList
//
//  Created by Jenkin on 16-9-7.
//  Copyright (c) 2016年 Yinhjpro. All rights reserved.
//

#import "YHJAddToDoItemViewController.h"

@interface YHJAddToDoItemViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation YHJAddToDoItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (sender != self.doneButton) {
        return;
    }
    if (self.textField.text.length >0) {
        self.addNewItem = [[YHJNewItem alloc]init];
        self.addNewItem.itemName = self.textField.text;
        self.addNewItem.completed = NO;
        
    }
    
}


@end
