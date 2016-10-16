//
//  YHJToDoListTableViewController.h
//  ToDoList
//
//  Created by Jenkin on 16-9-7.
//  Copyright (c) 2016年 Yinhjpro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHJToDoListTableViewController : UITableViewController

//2016.10.4
/*
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger section;
- (NSInteger) rowNumberForSection:(NSInteger)section;
- (NSURL*) coverURLForSection:(NSInteger)section row:(NSInteger)index;
- (NSString*) TitleForSection:(NSInteger)section row:(NSInteger)index;
- (NSString*) trackTitleForSection:(NSInteger)section row:(NSInteger)index;
- (NSString*) footNoteForSection:(NSInteger)section row:(NSInteger)index;
- (NSString*) mainTitleForSection:(NSInteger)section;
 */

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;

@end
