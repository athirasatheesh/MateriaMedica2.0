//
//  RemViewController.h
//  MyProto
//
//  Created by Rahul on 17/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RemViewController : UIViewController {
	IBOutlet UIWebView *webView;
	NSString *remedyName;
	NSString *searchString;
	NSMutableString *htmlString;
	BOOL bExactMatch;
}
- (id)initWithRemedy:(NSString *)remName andSearchString:(NSString *)theSearchString andExactMatch:(BOOL) theExactMatch ;
-(BOOL)copyhtmlFromResourceToDocumentsDirectory;
- (void)appendStringToHTML:(NSString *)remData forTag:(NSString *)tagName;
- (void)setHighLighting;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@end
