//
//  TDUserToDoItemManager.m
//  ToDoMap
//
//  Created by Ravi Vooda on 2/24/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "TDUserToDoItemManager.h"
#import <Realm/RLMRealm.h>

@implementation TDUserToDoItemManager
static TDUserToDoItemManager *defManager;

+(instancetype) defaultManager {
    if (!defManager) {
        defManager = [[TDUserToDoItemManager alloc] init];
        defManager.toDoItems = [[NSMutableArray alloc] init];
        
        for (TDObject *savedObject in [TDObject allObjectsInRealm:[RLMRealm defaultRealm]]) {
            [defManager.toDoItems addObject:savedObject];
        }
    }
    return defManager;
}

-(void) addToDoItem:(TDObject *)object {
    [self.toDoItems addObject:object];
    @synchronized(self) {
        RLMRealm *defRealm = [RLMRealm defaultRealm];
        [defRealm beginWriteTransaction];
        [defRealm addObject:object];
        [defRealm commitWriteTransaction];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"itemsChanged" object:nil];
}

-(void) backgroundSync {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(self) {
            RLMRealm *defRealm = [RLMRealm defaultRealm];
            [defRealm beginWriteTransaction];
            [defRealm deleteAllObjects];
            [defRealm addObjects:_toDoItems];
            [defRealm commitWriteTransaction];
        }
    });
}

@end
