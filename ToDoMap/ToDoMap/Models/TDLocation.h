//
//  TDLocation.h
//  ToDoMap
//
//  Created by Ravi Vooda on 2/26/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import <Realm.h>
#import <CoreLocation/CoreLocation.h>

@interface TDLocation : RLMObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) CLLocation *coordinates;
@property (strong, nonatomic) NSString *googlePlaceID;

-(instancetype) initWithGoogleResponse:(NSDictionary*)response;

-(void) fetchLocation;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<TDObjectClas>
RLM_ARRAY_TYPE(TDLocation)
