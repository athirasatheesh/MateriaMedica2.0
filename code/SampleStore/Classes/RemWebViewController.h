//
//  RemWebViewController.h
//  MyProto
//
//  Created by Rahul on 19/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RemWebViewController : UIViewController {
	IBOutlet UIWebView *webView;
	NSString * url;
}
- (id)initWithURLString:(NSString *)theURL andNibName:(NSString *)nibNameOrNil;
@end
