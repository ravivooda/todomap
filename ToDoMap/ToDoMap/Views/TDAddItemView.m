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

#define googleAPIKey @"AIzaSyA9f8kJ-B4_qP2ik6TqsZN7TGpU_Giw6UU"

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
        
        [self addSubview:_inputTextView];
        [self addSubview:_suggestionsTableView];
        
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
    [_suggestionsTableView setFrame:CGRectMake(0, textViewHeight, frame.size.width, frame.size.height - textViewHeight)];
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
    TDSuggestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[TDSuggestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"Suggestion: %ld",(long)indexPath.row]];
    return cell;
}

#pragma mark - Table View Delegate Methods
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Fetching suggestions Methods
-(void) fetchPlaceSuggestionsForString:(NSString*)string {
    NSString *url = @"https://maps.googleapis.com/maps/api/place/autocomplete/json?parameters";
    NSDictionary *parameters = @{@"input":string , @"key":googleAPIKey};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog([responseObject description]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
