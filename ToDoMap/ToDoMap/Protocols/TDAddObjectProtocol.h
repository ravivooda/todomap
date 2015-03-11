//
//  TDAddObjectProtocol.h
//  ToDoMap
//
//  Created by Ravi Vooda on 3/2/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDObject.h"

@interface TDAddObjectProtocol : NSObject

-(void) addToDoItem:(TDObject*)object;

-(void) refresh:(NSArray*)toDoItems;

@end
