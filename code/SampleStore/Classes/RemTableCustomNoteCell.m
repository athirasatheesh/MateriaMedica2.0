//
//  RemTableCustomNoteCell.m
//  MyProto
//
//  Created by Rahul on 18/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RemTableCustomNoteCell.h"


@implementation RemTableCustomNoteCell
@synthesize textView;

- (void)dealloc {
	[textView release];
    [super dealloc];
}


@end
