//
//  TDSearchViewController.h
//  ToDoMap
//
//  Created by Ravi Vooda on 3/2/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDAddObjectDelegate.h"

@interface TDSearchViewController : UIViewController <UISearchControllerDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id <TDAddObjectDelegate> addDelegate;

@end
