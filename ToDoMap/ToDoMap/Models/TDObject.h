//
//  TDObject.h
//  ToDoMap
//
//  Created by Ravi Vooda on 2/24/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef enum {
    TDObjectCreated,
    TDObjectInProgress,
    TDObjectCompleted,
    TDObjectDeleted
} TDObjectProgessState;

@interface TDObject : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *createdTime;
@property (nonatomic) TDObjectProgessState *state;
@property (strong, nonatomic) CLLocation *coordinates;

@end
