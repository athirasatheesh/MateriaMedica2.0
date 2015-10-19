//
//  RemWebViewController.m
//  MyProto
//
//  Created by Rahul on 19/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RemWebViewController.h"
#import "Common.h"

@implementation RemWebViewController


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
- (id)initWithURLString:(NSString *)theURL andNibName:(NSString *)nibNameOrNil
{
	if (self = [self initWithNibName:nibNameOrNil bundle:nil ]) {
        // Custom initialization
		url = theURL;
    }
    return self;
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationController.navigationBar.tintColor = defaulttintcolor;
	
	NSString *defaultFAQPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:url];
	//NSString *webList = [NSString stringWithContentsOfFile:defaultFAQPath ] ;
	NSString *webList = [NSString stringWithContentsOfFile:defaultFAQPath encoding:NSASCIIStringEncoding error:nil];
	
	
	[webView loadHTMLString:webList baseURL: nil] ;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
