//
//  RemTableCustomCell.m
//  MyProto
//
//  Created by Rahul on 18/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RemTableCustomCell.h"


@implementation RemTableCustomCell
@synthesize remName,imageView;


- (void)dealloc {
	[remName release];
	[imageView release];
    [super dealloc];
}


@end
