//
//  TDObject.m
//  ToDoMap
//
//  Created by Ravi Vooda on 2/24/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "TDObject.h"

@implementation TDObject

-(void) setState:(TDObjectProgessState *)state {
    @synchronized(self) {
        _state = state;
        
#warning Send a notification from here for reloading
    }
}

@end
