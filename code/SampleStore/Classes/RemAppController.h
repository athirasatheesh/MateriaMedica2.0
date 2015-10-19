//
//  RemAppController.h
//  MyProto
//
//  Created by Rahul on 19/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemSplashViewController.h"
#import "RemWebViewController.h"

@interface RemAppController : NSObject<UITabBarControllerDelegate> {
	UIWindow					*applicationWindow;	
	UITabBarController			*tabBarController;
	RemSplashViewController		*splashScreenViewController;
	RemWebViewController		*licenseViewController;
}
- (id)initWithWindow:(UIWindow *)appWindow;
- (void)doViewTransitionAnimation;
- (void)createTabBar;
- (void)loadApplication;
- (UINavigationController *)createNavigationController:(UIViewController *)theViewController 
												 title:(NSString *)theTitle 
												 image:(UIImage *)theImage;
- (BOOL)copyDatabaseFromResourceToDocumentsDirectory;

@end
