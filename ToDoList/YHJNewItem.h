//
//  YHJNewItem.h
//  ToDoList
//
//  Created by Jenkin on 16-9-7.
//  Copyright (c) 2016年 Yinhjpro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHJNewItem : NSObject<NSCoding>

@property (nonatomic,copy)NSString* itemName;
@property (nonatomic,assign)BOOL completed;

@end
