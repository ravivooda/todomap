//
//  TDObject.h
//  ToDoMap
//
//  Created by Ravi Vooda on 2/24/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import <Realm.h>

@class TDLocation;

@interface TDObject : RLMObject

@property NSString *title;
@property NSDate *createdTime;
@property TDLocation *coordinates;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<TDObjectClas>
RLM_ARRAY_TYPE(TDObject)
