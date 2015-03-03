//
//  TDAddItemView.h
//  ToDoMap
//
//  Created by Ravi Vooda on 2/25/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDAddItemView : UIView <UITextViewDelegate, UITableViewDataSource, UITableViewDelegate, UIKeyInput>

@property (strong, nonatomic, readonly) UITextView *inputTextView;
@property (strong, nonatomic, readonly) UITableView *suggestionsTableView;

-(void) flush;

@end
