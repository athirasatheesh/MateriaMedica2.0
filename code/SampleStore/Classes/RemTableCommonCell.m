//
//  RemTableCommonCell.m
//  MyProto
//
//  Created by Rahul on 18/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RemTableCommonCell.h"


@implementation RemTableCommonCell
@synthesize remName;



- (void)dealloc {
	[remName release];
    [super dealloc];
}


@end
