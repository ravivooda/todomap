//
//  TDAddItemView.m
//  ToDoMap
//
//  Created by Ravi Vooda on 2/25/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "TDAddItemView.h"
#import "TDSuggestionTableViewCell.h"
#import <AFNetworking.h>
#import "TDLocation.h"

#define googleAPIKey @"AIzaSyBx5XW_Jr0lx0dON3WBOLJ9TDbn8zDC1W8"

#define textViewHeight 50
#define tableViewMaxHeight 150

@interface TDAddItemView ()

@property (strong, nonatomic) NSMutableArray *suggestionItems;

@end

@implementation TDAddItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype) init {
    self = [super init];
    if (self) {
        _inputTextView = [[UITextView alloc] init];
        _suggestionsTableView = [[UITableView alloc] init];
        
        [_inputTextView setDelegate:self];
        [_suggestionsTableView setDataSource:self];
        [_suggestionsTableView setDelegate:self];

        [self addSubview:_inputTextView];
        
        [_inputTextView setInputAccessoryView:_suggestionsTableView];
        
        [_inputTextView setAutocorrectionType:UITextAutocorrectionTypeNo];
        
        _suggestionItems = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) setFrame:(CGRect)frame {
    if (frame.size.height < textViewHeight) {
        frame.size.height = textViewHeight;
    }
    [super setFrame:frame];
    [_inputTextView setFrame:CGRectMake(0, 0, frame.size.width, textViewHeight)];
    [_suggestionsTableView setFrame:CGRectMake(0, textViewHeight, frame.size.width, textViewHeight)];
}

#pragma mark - Text View Delegate Methods
-(void)textViewDidChange:(UITextView *)textView {
    [self fetchPlaceSuggestionsForString:textView.text];
}

#pragma mark - Table View Datasource Methods
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _suggestionItems.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"suggestionCellIdentifier";
    TDSuggestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TDSuggestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    TDLocation *cellObject = [_suggestionItems objectAtIndex:indexPath.row];
    [cell setLocation:cellObject];
    return cell;
}

#pragma mark - Table View Delegate Methods
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *googlePlaceID = [(TDLocation*)[_suggestionItems objectAtIndex:indexPath.row] googlePlaceID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@",googlePlaceID, googleAPIKey];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog([responseObject description]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - Fetching suggestions Methods
-(void) fetchPlaceSuggestionsForString:(NSString*)string {
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=%@",googleAPIKey];
    NSDictionary *parameters = @{@"input":string , @"key":googleAPIKey};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _suggestionItems = [[NSMutableArray alloc] init];
        if ([[responseObject objectForKey:@"status"] isEqualToString:@"OK"]) {
            for (NSDictionary *placeDictionary in [responseObject objectForKey:@"predictions"]) {
                TDLocation *location = [[TDLocation alloc] initWithGoogleResponse:placeDictionary];
                [_suggestionItems addObject:location];
            }
            [_suggestionsTableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - Key Input Protocol Methods
-(BOOL) hasText {
    return ![_inputTextView.text isEqualToString:@""];
}

-(void) insertText:(NSString *)text {
    [_inputTextView insertText:text];
    
}

-(void) deleteBackward {
    [_inputTextView deleteBackward];
}

#pragma mark - Rest Methods
-(void) flush {
    [_inputTextView setText:@""];
    _suggestionItems = [[NSMutableArray alloc] init];
    
    [_suggestionsTableView reloadData];
}

-(BOOL) canBecomeFirstResponder {
    [_inputTextView becomeFirstResponder];
    return false;
}

@end
