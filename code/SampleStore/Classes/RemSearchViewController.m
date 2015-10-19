//
//  RemSearchViewController.m
//  MyProto
//
//  Created by Rahul on 21/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RemSearchViewController.h"
#import "Common.h"
#import "JMSBDBMgrWrapper.h"
#import "RemViewController.h"

@implementation RemSearchViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationController.navigationBar.tintColor = defaulttintcolor;
	[remTable setBackgroundColor:[UIColor blackColor]];
	if(!remedyList)
	{
		remedyList = [[NSMutableArray alloc]init];
	}
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)thesearchText 
{ 
	//
	if ([thesearchText length] == 0) [searchBar resignFirstResponder]; 
} 

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar 
{ 
	searchText =  [searchBar.text retain];
	[self PerformSearch:searchText];
	[remTable reloadData];
	[searchBar resignFirstResponder]; 
} 

- (void) PerformSearch:(NSString *)theSearchText
{
	[remedyList removeAllObjects];
	NSArray *array;
	array = [[JMSBDBMgrWrapper sharedWrapper] searchRemediesforMatch:theSearchText forExactMatch:matchSwitch.on];
	if ([array count] > 0)
	{
		for (int index = 0 ; index <[array count]; index++ )
		{
			NSString *NameofRemedy = [[array objectAtIndex:index]objectForKey:K_REM_NAME];
			if (NameofRemedy)
			{
				[remedyList addObject:NameofRemedy];
			}
		}

	}
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [remedyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	RemTableCommonCell *cell = (RemTableCommonCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if(cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"RemTableCommonCell" owner:self options:nil];
		cell = tblCell;
	}
	//// imagebackdrnd
	NSString *bgImageName = @"";
	
	bgImageName = [NSString stringWithString:TABLE_MIDDLE_ROW_IMAGE_NAME];
	
	/*if([remTable numberOfRowsInSection:indexPath.section] == 1){
		bgImageName = [NSString stringWithString:TABLE_SINGLE_ROW_IMAGE_NAME];
	}
	else
	{
		if (indexPath.row == 0)
		{
			bgImageName = [NSString stringWithString:TABLE_TOP_ROW_IMAGE_NAME];
			
		}
		else if (indexPath.row == ([remTable numberOfRowsInSection:indexPath.section] - 1)) 
		{
			bgImageName = [NSString stringWithString:TABLE_BOTTOM_ROW_IMAGE_NAME];
			
		}
		else
		{
			
			
		}
	}	*/
	////
	UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:cell.frame];//initWithImage:[UIImage imageNamed:@"CellBg.png"]];
	backgroundImageView.image = [UIImage imageNamed:bgImageName];
	
	
	cell.backgroundView = backgroundImageView;
	[backgroundImageView release];
	[cell.remName setTextColor:[UIColor whiteColor]];
	cell.remName.text = [remedyList objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	return cell;
	
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	RemViewController *remViewController = [[RemViewController alloc]initWithRemedy:[remedyList objectAtIndex:indexPath.row] andSearchString:searchText andExactMatch:matchSwitch.on];
	[[self navigationController]pushViewController:remViewController animated:YES];
	[remViewController release];
	[self performSelector:@selector(deselect) withObject:NULL afterDelay:0.5]; 
}
- (void) deselect 
{ 
	[remTable deselectRowAtIndexPath:[remTable indexPathForSelectedRow] animated:YES]; 
	
} 
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
	[remedyList release];
	[searchText release];
    [super dealloc];
}


@end
