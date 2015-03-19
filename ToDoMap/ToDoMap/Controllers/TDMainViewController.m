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
#import "TDLocation.h"

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadToDos) name:@"itemsChanged" object:nil];
    [self reloadToDos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) reloadToDos {
    // Reload Data
    _displayToDoItemsArray = [[TDUserToDoItemManager defaultManager] toDoItems];
    
    // Mapview Reload
    id userLocation = [_mapView userLocation];
    NSMutableArray *mapAnnotations = [[NSMutableArray alloc] initWithArray:[_mapView annotations]];
    if (userLocation) {
        [mapAnnotations removeObject:userLocation];
    }
    [_mapView removeAnnotations:mapAnnotations];
    
    for (TDObject *toDoObject in _displayToDoItemsArray) {
        if (![toDoObject.coordinates.latitude isEqualToString:@""]) {
            MKPointAnnotation *toDoAnnotation = [[MKPointAnnotation alloc] init];
            toDoAnnotation.coordinate = CLLocationCoordinate2DMake([toDoObject.coordinates.latitude floatValue], [toDoObject.coordinates.longitude floatValue]);
            [_mapView addAnnotation:toDoAnnotation];
        }
    }
    
    
    // TableView Reload
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

-(BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _displayToDoItemsArray.count - 1) {
        return NO;
    }
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[TDUserToDoItemManager defaultManager] moveItemFromPosition:(int)sourceIndexPath.row toPosition:(int)destinationIndexPath.row];
    [self reloadToDos];
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
