//
//  TDUserToDoItemManager.m
//  ToDoMap
//
//  Created by Ravi Vooda on 2/24/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "TDUserToDoItemManager.h"

@implementation TDUserToDoItemManager
static TDUserToDoItemManager *defManager;

+(instancetype) defaultManager {
    if (!defManager) {
        defManager = [[TDUserToDoItemManager alloc] init];
        defManager.toDoItems = [[NSMutableArray alloc] init];
    }
    return defManager;
}

-(void) addToDoItem:(TDObject *)object {
    [self.toDoItems addObject:object];
}

@end
