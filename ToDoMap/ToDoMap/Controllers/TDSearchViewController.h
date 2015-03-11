//
//  TDSearchViewController.h
//  ToDoMap
//
//  Created by Ravi Vooda on 3/2/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDAddObjectProtocol.h"

@interface TDSearchViewController : UIViewController

@property (weak, nonatomic) TDAddObjectProtocol *delegate;

@end
