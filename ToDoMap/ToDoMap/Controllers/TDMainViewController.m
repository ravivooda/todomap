//
//  ViewController.m
//  ToDoMap
//
//  Created by Ravi Vooda on 2/20/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "TDMainViewController.h"
#import "TDUserToDoItemManager.h"
#import "TDItemTableViewCell.h"
#import "TDAddItemView.h"
#import "TDSearchViewController.h"

@interface TDMainViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *displayToDoItemsArray;

@property (strong, nonatomic) TDAddItemView *addItemView;

@end

@implementation TDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _addItemView = [[TDAddItemView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) reloadToDos {
    // Mapview Reload
    id userLocation = [_mapView userLocation];
    NSMutableArray *mapAnnotations = [[NSMutableArray alloc] initWithArray:[_mapView annotations]];
    if (userLocation) {
        [mapAnnotations removeObject:userLocation];
    }
    [_mapView removeAnnotations:mapAnnotations];
    
    
    // TableView Reload
    _displayToDoItemsArray = [[TDUserToDoItemManager defaultManager] toDoItems];
    [_tableView reloadData];
}

-(void) addItemHandler {
    /*[_addItemView flush];
    [_addItemView setFrame:CGRectMake(0, 0, self.view.frame.size.width, _addItemView.frame.size.height)];
    [self.view addSubview:_addItemView];
    
    [_addItemView becomeFirstResponder];*/
    static NSString *searchControllerIdentifier = @"locationSearchViewController";
//    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:searchControllerIdentifier];
    TDSearchViewController *locationSearchViewController = [self.storyboard instantiateViewControllerWithIdentifier:searchControllerIdentifier];
    locationSearchViewController.addDelegate = self;
    [self presentViewController:locationSearchViewController animated:YES completion:nil];
}

#pragma mark - Table View Delegate Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _displayToDoItemsArray.count + 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _displayToDoItemsArray.count) {
        static NSString *cellIdentifier = @"todoItemTableViewCellIdentifier";
        TDItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[TDItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.toDoItem = _displayToDoItemsArray[indexPath.row];
        return cell;
    } else {
        static NSString *cellIdentifier = @"todoItemAddCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell.textLabel setText:@"Add"];
        return cell;
    }
}

#pragma mark - Table View Delegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _displayToDoItemsArray.count) {
        [self addItemHandler];
    }
}

-(void) refresh:(NSArray *)toDoItems {
#warning Have to implement this
}

-(void) addToDoItem:(TDObject *)object {
#warning Have to implement this
}

@end
