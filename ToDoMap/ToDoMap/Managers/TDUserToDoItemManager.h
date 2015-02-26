//
//  TDUserToDoItemManager.h
//  ToDoMap
//
//  Created by Ravi Vooda on 2/24/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDObject.h"

@interface TDUserToDoItemManager : NSObject

@property (strong, nonatomic) NSMutableArray *toDoItems;

-(void) addToDoItem:(TDObject*)object;

+(instancetype) defaultManager;

@end
