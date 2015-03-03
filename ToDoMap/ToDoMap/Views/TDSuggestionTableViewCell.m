//
//  TDSuggestionTableViewCell.m
//  ToDoMap
//
//  Created by Ravi Vooda on 2/25/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "TDSuggestionTableViewCell.h"

@implementation TDSuggestionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setLocation:(TDLocation *)location {
    @synchronized(self) {
        _location = location;
        [self.textLabel setText:location.name];
    }
}

@end
