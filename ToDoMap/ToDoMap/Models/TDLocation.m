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

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"latitude" : @"" , @"longitude" : @""};
}

-(instancetype) initWithGoogleResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        _googlePlaceID = [response objectForKey:@"place_id"];
        _googleReferenceID = [response objectForKey:@"reference"];
        
        _name = [response objectForKey:@"description"];
    }
    return self;
}

-(void) fetchLocation:(void (^)())completedBlock errorBlock:(void (^)(NSError *))errorBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@",_googlePlaceID, googleAPIKey];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *geometry = [[[responseObject objectForKey:@"result"] objectForKey:@"geometry"] objectForKey:@"location"];
        _latitude = [NSString stringWithFormat:@"%@", [geometry objectForKey:@"lat"]];
        _longitude = [NSString stringWithFormat:@"%@", [geometry objectForKey:@"lng"]];
        completedBlock();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorBlock(error);
    }];
}

@end
