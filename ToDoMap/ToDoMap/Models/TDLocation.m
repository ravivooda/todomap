//
//  TDLocation.m
//  ToDoMap
//
//  Created by Ravi Vooda on 2/26/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "TDLocation.h"
#import <AFNetworking.h>

#define googleAPIKey @"AIzaSyBx5XW_Jr0lx0dON3WBOLJ9TDbn8zDC1W8"

@interface TDLocation ()

@property (strong, nonatomic) NSString *googleReferenceID;

@end

@implementation TDLocation

-(instancetype) initWithGoogleResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        _googlePlaceID = [response objectForKey:@"place_id"];
        _googleReferenceID = [response objectForKey:@"reference"];
        
        _name = [response objectForKey:@"description"];
    }
    return self;
}

-(void) fetchLocation {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@",_googlePlaceID, googleAPIKey];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog([responseObject description]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
