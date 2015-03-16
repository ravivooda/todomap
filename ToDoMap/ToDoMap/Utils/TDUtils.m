//
//  TDUtils.m
//  ToDoMap
//
//  Created by Ravi Vooda on 3/16/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "TDUtils.h"
#import <AFNetworking.h>
#import "TDLocation.h"

@implementation TDUtils

//#pragma mark - Fetching suggestions Methods
//-(NSArray*) fetchPlaceSuggestionsForString:(NSString*)string {
//    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=%@",googleAPIKey];
//    NSDictionary *parameters = @{@"input":string , @"key":googleAPIKey};
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSMutableArray *suggestionItems = [[NSMutableArray alloc] init];
//        if ([[responseObject objectForKey:@"status"] isEqualToString:@"OK"]) {
//            for (NSDictionary *placeDictionary in [responseObject objectForKey:@"predictions"]) {
//                TDLocation *location = [[TDLocation alloc] initWithGoogleResponse:placeDictionary];
//                [suggestionItems addObject:location];
//            }
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//}

@end
