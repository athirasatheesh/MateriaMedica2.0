//
//  SampleStoreAppDelegate.m
//  SampleStore
//
//  Created by Rahul on 22/12/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "SampleStoreAppDelegate.h"
#import "RemAppController.h"

@implementation SampleStoreAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

	RemAppController *appController = [[RemAppController alloc]initWithWindow:window];
	[appController loadApplication];
    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
