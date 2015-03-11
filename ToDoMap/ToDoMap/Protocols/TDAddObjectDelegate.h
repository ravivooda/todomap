//
//  TDAddObjectDelegate.h
//  ToDoMap
//
//  Created by Ravi Vooda on 3/10/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDObject.h"

@protocol TDAddObjectDelegate <NSObject>

-(void) addToDoItem:(TDObject*)object;

-(void) refresh:(NSArray*)toDoItems;

@end
