//
//  TDItemTableViewCell.m
//  ToDoMap
//
//  Created by Ravi Vooda on 2/25/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "TDItemTableViewCell.h"

@implementation TDItemTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setToDoItem:(TDObject *)toDoItem {
    @synchronized(self) {
        _toDoItem = toDoItem;
        [self.textLabel setText:_toDoItem.title];
    }
}

@end
