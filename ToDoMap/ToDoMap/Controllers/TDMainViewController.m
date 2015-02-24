//
//  ViewController.m
//  ToDoMap
//
//  Created by Ravi Vooda on 2/20/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "TDMainViewController.h"

@interface TDMainViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
