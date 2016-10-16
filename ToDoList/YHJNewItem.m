//
//  YHJNewItem.m
//  ToDoList
//
//  Created by Jenkin on 16-9-7.
//  Copyright (c) 2016年 Yinhjpro. All rights reserved.
//

#import "YHJNewItem.h"

@implementation YHJNewItem

@synthesize itemName = _itemName;
@synthesize completed = _completed;

- (void)encodeWithCoder:(NSCoder *)enCoder{
    [enCoder encodeObject:self.itemName forKey:@"itemName"];
    [enCoder encodeBool:self.completed forKey:@"completed"];
}

- (id)initWithCoder:(NSCoder *)decoder{
    self.itemName = [decoder decodeObjectForKey:@"itemName"];
    self.completed = [decoder decodeBoolForKey:@"completed"];
    return self;
}

@end
