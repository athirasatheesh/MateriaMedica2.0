//
//  RemAppController.m
//  MyProto
//
//  Created by Rahul on 19/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RemAppController.h"
#import "ChampViewController.h"
#import "RemViewController.h"
#import "ChampViewController.h"
#import "RemNotesListViewController.h"
#import "RemSearchViewController.h"
#import "RemInfoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Common.h"

@implementation RemAppController
- (id) initWithWindow:(UIWindow *)appWindow
{
	if (self = [super init])
	{
		applicationWindow = appWindow;
	}
	return self;
}
- (void)createTabBar
{
	[self doViewTransitionAnimation];
	
	[splashScreenViewController.view removeFromSuperview];
	[splashScreenViewController release];
	splashScreenViewController = nil;
	[self copyDatabaseFromResourceToDocumentsDirectory];
	
	//RemViewController *remViewController = [[RemViewController alloc]initWithRemedy:@"ALLIUM CEPA"];
	tabBarController = [[UITabBarController alloc] init];
	tabBarController.delegate = self;
	NSMutableArray *tabBarControllerArray = [[NSMutableArray alloc] init];
	
	// Remedy tab
	
	ChampViewController *champViewController = nil;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
	{
		champViewController = [[ChampViewController alloc] initWithNibName:@"ChampViewController-iPad" bundle:nil];
	} 
	else 
	{
		champViewController = [[ChampViewController alloc] initWithNibName:@"ChampViewController" bundle:nil];
	}

	UINavigationController *champNavigationController =  nil;
	champNavigationController = [self createNavigationController:champViewController 
														 title: @"Remedies"
														 image:RemLoadImageResource(@"remedy_tab")];
	[champViewController release];
	[tabBarControllerArray addObject:champNavigationController];
	[champNavigationController release];
	
	RemSearchViewController *searchViewController = nil;

	// Search tab
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
	{
		searchViewController = [[RemSearchViewController alloc] initWithNibName:@"RemSearchViewController-iPad" bundle:nil];
	} 
	else 
	{
		searchViewController = [[RemSearchViewController alloc] initWithNibName:@"RemSearchViewController" bundle:nil];
	}
	

	UINavigationController *searchNavigationController =  nil;
	searchNavigationController = [self createNavigationController:searchViewController 
														   title: @"Search"
														   image:RemLoadImageResource(@"search_tab")];
	[searchViewController release];
	[tabBarControllerArray addObject:searchNavigationController];
	[searchNavigationController release];
	
	
	// Notes tab
	RemNotesListViewController *noteslistViewController  = nil;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
	{
		noteslistViewController = [[RemNotesListViewController alloc] initWithNibName:@"RemNotesListViewController-iPad" bundle:nil];
	} 
	else 
	{
		noteslistViewController = [[RemNotesListViewController alloc] initWithNibName:@"RemNotesListViewController" bundle:nil];
	}

	UINavigationController *noteslistNavigationController =  nil;
	noteslistNavigationController = [self createNavigationController:noteslistViewController 
														 title: @"Notes"
														 image:RemLoadImageResource(@"notes_tab")];
	[noteslistViewController release];
	[tabBarControllerArray addObject:noteslistNavigationController];
	[noteslistNavigationController release];
	

	
	RemWebViewController		*faqViewController = nil;
	// FAQ tab

	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
	{
		faqViewController = [[RemWebViewController alloc] initWithURLString:FAQ_FILE andNibName:@"RemWebViewController-iPad"];
	} 
	else 
	{
		faqViewController = [[RemWebViewController alloc] initWithURLString:FAQ_FILE andNibName:@"RemWebViewController"];
	}

	UINavigationController *faqNavigationController =  nil;
	faqNavigationController = [self createNavigationController:faqViewController 
														 title: @"FAQ"
														 image:RemLoadImageResource(@"faq_tab")];
	[faqViewController release];
	[tabBarControllerArray addObject:faqNavigationController];
	[faqNavigationController release];
	
	
	
	// info tab
	RemInfoViewController * infoViewController = nil;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
	{
		infoViewController = [[RemInfoViewController alloc] initWithNibName:@"RemInfoViewController-iPad" bundle:nil];
	} 
	else 
	{
		infoViewController = [[RemInfoViewController alloc] initWithNibName:@"RemInfoViewController" bundle:nil];
	}

	
	UINavigationController *infoNavigationController =  nil;
	infoNavigationController = [self createNavigationController:infoViewController 
														  title: @"Info"
														  image:RemLoadImageResource(@"info_tab")];
	[infoViewController release];
	[tabBarControllerArray addObject:infoNavigationController];
	[infoNavigationController release];
	
	//
	// set tab bar array
	tabBarController.viewControllers = tabBarControllerArray;
	tabBarController.customizableViewControllers = tabBarControllerArray; 
	tabBarController.delegate = self; 
	
	tabBarController.selectedIndex = 0 ;
	[tabBarControllerArray release];
	tabBarController.view.tag = 1001;
	[applicationWindow addSubview:tabBarController.view];
}
- (void)showSplashScreen
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
	{
		splashScreenViewController = [[RemSplashViewController alloc] initWithNibName:@"RemSplashViewController-iPad" bundle:nil];
	} 
	else 
	{
		splashScreenViewController = [[RemSplashViewController alloc] initWithNibName:@"RemSplashViewController" bundle:nil];
	}
	[applicationWindow addSubview:splashScreenViewController.view];
}

- (void) loadApplication
{
	[self showSplashScreen];
	[self performSelector:@selector(createTabBar) withObject:nil afterDelay:0.2];

}
- (BOOL)copyDatabaseFromResourceToDocumentsDirectory
{
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filepath = [documentsDirectory stringByAppendingPathComponent:kNotesDatabaseName];
	
	success = [fileManager fileExistsAtPath:filepath];
	
	if (success) return YES;
	
	NSString *defaultPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kNotesDatabaseName];
	
	success = [fileManager copyItemAtPath:defaultPath toPath:filepath error:&error];
	return success;
}

//	Function	:	doViewTransitionAnimation
//	Purpose		:	to do view transition animation
//	Parameter	:	nil
//	Return		:	nil
- (void)doViewTransitionAnimation
{
	CATransition *animation = [CATransition animation];
	animation.delegate = self;
	animation.duration = 0.3;
	animation.type = kCATransitionFade;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	[[applicationWindow layer] addAnimation:animation forKey:@"dissolve"];
}
//	Function	:	createNavigationController
//	Purpose		:	to create navigation controller for a specified view controller 
//	Parameter	:	theViewController 
//				:	theTitle 
//				:	theImage 
//	Return		:	UINavigationController 
- (UINavigationController *)createNavigationController:(UIViewController *)theViewController 
												 title:(NSString *)theTitle 
												 image:(UIImage *)theImage
{
	// set title and image for tab bar
	theViewController.tabBarItem.title = theTitle;
	theViewController.tabBarItem.image = theImage;
	// set title for view controller
	theViewController.title = theTitle;
	
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:theViewController];
	return aNavigationController;
}

@end
