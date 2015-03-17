//
//  TDSearchViewController.m
//  ToDoMap
//
//  Created by Ravi Vooda on 3/2/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "TDSearchViewController.h"
#import <AFNetworking.h>
#import "TDLocation.h"
#import "TDSuggestionTableViewCell.h"
#import "TDObject.h"
#import "TDUserToDoItemManager.h"

#define googleAPIKey @"AIzaSyBx5XW_Jr0lx0dON3WBOLJ9TDbn8zDC1W8"

@interface TDSearchViewController ()

@property (strong, atomic) NSMutableArray *searchResults;
@property (weak, nonatomic) IBOutlet UITableView *searchResultsTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic) BOOL isLocationSearching;

@property (strong, atomic) TDObject *aNewItem;

@end

@implementation TDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _aNewItem = [[TDObject alloc] init];
    _isLocationSearching = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Search Controller Delegate Methods
-(void) willPresentSearchController:(UISearchController *)searchController {
    NSLog(@"Will present search controller");
}

-(void) didPresentSearchController:(UISearchController *)searchController {
    NSLog(@"Did present search controller");
}

#pragma mark - Search Bar Delegate Methods
-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Should fetch complete for the text: %@", searchText);
    [_aNewItem setTitle:searchText];
    NSArray *componentItems = [searchText componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    if ([componentItems count] > 0) {
        NSString *lastItem = [componentItems objectAtIndex:componentItems.count - 1];
        if (![lastItem isEqualToString:@""] && [[lastItem substringToIndex:1] isEqualToString:@"#"]) {
            [self fetchPlaceSuggestionsForString:[lastItem substringFromIndex:1]];
            if (!_isLocationSearching) {
                _isLocationSearching = true;
                [self.searchResultsTableView reloadData];
            }
        } else {
            _searchResults = [[NSMutableArray alloc] init];
            [self.searchResultsTableView reloadData];
            _isLocationSearching = false;
        }
    }
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Bar button clicked");
    [_aNewItem setCreatedTime:[NSDate date]];
    [[TDUserToDoItemManager defaultManager] addToDoItem:_aNewItem];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Fetching suggestions Methods
-(void) fetchPlaceSuggestionsForString:(NSString*)string {
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=%@",googleAPIKey];
    NSDictionary *parameters = @{@"input":string , @"key":googleAPIKey};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _searchResults = [[NSMutableArray alloc] init];
        if ([[responseObject objectForKey:@"status"] isEqualToString:@"OK"]) {
            for (NSDictionary *placeDictionary in [responseObject objectForKey:@"predictions"]) {
                TDLocation *location = [[TDLocation alloc] initWithGoogleResponse:placeDictionary];
                [_searchResults addObject:location];
            }
            [_searchResultsTableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

#pragma mark - Table View Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!_isLocationSearching) {
        return 0;
    }
    return _searchResults.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"suggestionCellIdentifier";
    TDSuggestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TDSuggestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    TDLocation *cellObject = [_searchResults objectAtIndex:indexPath.row];
    [cell setLocation:cellObject];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Set the location for the item
    [_aNewItem setCoordinates:[_searchResults objectAtIndex:indexPath.row]];
    _isLocationSearching = false;
    [self.searchResultsTableView reloadData];
    
    NSString *title = _searchBar.text;
    int point = (int)[title rangeOfString:@"#"].location;
    NSString *completedTitle = [[title substringToIndex:point] stringByAppendingString:[(TDLocation*)[_searchResults objectAtIndex:indexPath.row] name]];
    [_searchBar setText:completedTitle];
    [_aNewItem setTitle:completedTitle];
}

@end
