//
//  YHJToDoListTableViewController.m
//  ToDoList
//
//  Created by Jenkin on 16-9-7.
//  Copyright (c) 2016年 Yinhjpro. All rights reserved.
//

#import "YHJToDoListTableViewController.h"
#import "YHJNewItem.h"
#import "YHJAddToDoItemViewController.h"

@interface YHJToDoListTableViewController ()

@property NSMutableArray *NewItems;
//2016.9.8 modified
@property NSString* storeFilename;//本地持久化存储文件

//2016.10.4




@end

@implementation YHJToDoListTableViewController

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    YHJAddToDoItemViewController* source = [segue sourceViewController];
    YHJNewItem* item = source.addNewItem;
    //NSString* tmpPath = self.storeFilename;
    if (item != nil) {
        [self.NewItems addObject:item];
        [self.tableView reloadData];
        
        //2016.9.8 modified:数据存入 本地文件
        //[self.NewItems writeToFile:self.storeFilename atomically:YES];
        //YHJNewItem* addToItem = [[YHJNewItem alloc]init];
        
        //[NSKeyedArchiver archiveRootObject:self.NewItems toFile: self.storeFilename];
    }
}

- (void)initialData{
    
    //2016.9.8 modified: 从本地文件 读取数据
    //NSArray* storedItems = [NSArray arrayWithContentsOfFile:self.storeFilename];
    
    NSMutableArray* getStoredItems = [[NSMutableArray alloc] init];
    //YHJNewItem* storedItem;
    NSUInteger i;
    
    getStoredItems = [NSKeyedUnarchiver unarchiveObjectWithFile:self.storeFilename];
    
    if (getStoredItems.count > 0) {
        //NSUInteger tmp = getStoredItems.count;
        for (i=0; i<getStoredItems.count; i++) {
            
            [self.NewItems addObject:getStoredItems[i]];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //2016.9.8 modified: 初始化 本地存储文件
    NSString* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    self.storeFilename = [path stringByAppendingPathComponent:@"test.archiver"];
    NSLog(@"%@", self.storeFilename);
    
    self.NewItems = [[NSMutableArray alloc] init];
    [self initialData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.NewItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* celltmp = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celltmp forIndexPath:indexPath];
    
    YHJNewItem* newItem = [self.NewItems objectAtIndex:indexPath.row];
    cell.textLabel.text = newItem.itemName;
    
    // Configure the cell...
    
    if (newItem.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    //更新本地存储文件
    [NSKeyedArchiver archiveRootObject:self.NewItems toFile: self.storeFilename];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    YHJNewItem* tappedItem = [self.NewItems objectAtIndex:indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/



//设置编辑风格EditingStyle
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*if (self.testTableView.editing)
        //通过表视图是否处于编辑状态来选择是左滑删除，还是多选删除。
    {
        //当表视图处于没有未编辑状态时选择多选删除
        return UITableViewCellEditingStyleDelete| UITableViewCellEditingStyleInsert;
    }
    else
    {
        //当表视图处于没有未编辑状态时选择左滑删除
        return UITableViewCellEditingStyleDelete;
    }*/
    
    //当表视图处于没有未编辑状态时选择左滑删除
    return UITableViewCellEditingStyleDelete;
}


// Override to support editing the table view.
//根据不同的editingstyle执行数据删除操作（点击左滑删除按钮的执行的方法）
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.NewItems removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
    //更新本地存储文件
    [NSKeyedArchiver archiveRootObject:self.NewItems toFile: self.storeFilename];
}

//修改左滑删除按钮的title
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
