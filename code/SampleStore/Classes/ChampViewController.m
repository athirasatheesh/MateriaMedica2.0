//
//  ChampViewController.m
//  MyProto
//
//  Created by Rahul on 12/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ChampViewController.h"
#import "RemTableCustomCell.h"
#import "JMSBDBMgrWrapper.h"
#import "RemViewController.h"
#import "Common.h"

#define ROW_HEIGHT 44.0f

@implementation ChampViewController


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationController.navigationBar.tintColor = defaulttintcolor;
	[remTable setBackgroundColor:[UIColor clearColor]];
	//[remTable setBackgroundColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.35f]]; 
								
	if(!remedyList)
	{
		remedyList = [[NSMutableArray alloc]init];
	}
	NSArray *remTemp;
	remTemp = [[JMSBDBMgrWrapper sharedWrapper] findAllRemedies];
	if ([remTemp count] > 0)
	{
		for (int index = 0; index < [remTemp count]; index++) 
		{
			NSString *remName = [[remTemp objectAtIndex:index]objectForKey:K_REM_NAME];
			if (remName)
			{
				[remedyList addObject:remName];
			}
		}
	}
	// Build the sorted section array
    [self createSectionList:remedyList];
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

// Each row array object contains the members for that section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [[sectionArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	RemTableCustomCell *cell = (RemTableCustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if(cell == nil) 
	{
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
		{
			[[NSBundle mainBundle] loadNibNamed:@"RemTableCustomCell-iPad" owner:self options:nil];
		} 
		else 
		{
			[[NSBundle mainBundle] loadNibNamed:@"RemTableCustomCell" owner:self options:nil];
		}
		
		
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
			bgImageName = [NSString stringWithString:TABLE_MIDDLE_ROW_IMAGE_NAME];
			
		}
	}	*/
	////
	UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:cell.frame];//initWithImage:[UIImage imageNamed:@"CellBg.png"]];
	backgroundImageView.image = [UIImage imageNamed:bgImageName];

	
	cell.backgroundView = backgroundImageView;
	[backgroundImageView release];
	
	//cell.backgroundColor = [UIColor purpleColor];
	
//	CGRect imageFrame = cell.contentView.bounds;
//	imageFrame.origin.x = imageFrame.size.width - 15; 
//	imageFrame.origin.y = imageFrame.origin.y + 13; 
//	imageFrame.size.width = 12; 
//	imageFrame.size.height = 17; 
//	
//    UIImageView *Imgview =  [[UIImageView alloc]initWithFrame:imageFrame];
//    [Imgview setImage:[UIImage imageNamed:TABLE_ACCESSORY_IMAGE_NAME]];
    //cell.accessoryView = Imgview;

	
	[cell.imageView setImage:[UIImage imageNamed:@"Acon_K.png"]];
	[cell.remName setTextColor:[UIColor whiteColor]];
	cell.remName.text = [[sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	RemViewController *remViewController = [[RemViewController alloc]initWithRemedy:[[sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] andSearchString:nil andExactMatch:NO];
	[self.navigationController pushViewController:remViewController animated:YES];
	[remViewController release];
	[self performSelector:@selector(deselect) withObject:NULL afterDelay:0.5]; 
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	return ROW_HEIGHT;
}
// One section for each alphabet member
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return [sectionArray count];
}
// Adding a section index here 
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView 
{ 
	return ALPHA_ARRAY; 
} 
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index ;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
//{ 
//	return [NSString stringWithFormat:@"%@", [ALPHA_ARRAY objectAtIndex:section]]; 
//} 


// Build a section/row list from the alphabetically ordered word list
- (void) createSectionList: (id) remedyArray
{
	// Build an array with 26 sub-array sections
	sectionArray = [[NSMutableArray alloc] init];
	for (int i = 0; i < 26; i++) [sectionArray addObject:[[NSMutableArray alloc] init]];
	
	// Add each word to its alphabetical section
	for (NSString *remedy in remedyArray)
	{
		if ([remedy length] == 0) continue;
		
		// determine which letter starts the name
		NSRange range = [ALPHA rangeOfString:[[remedy substringToIndex:1] uppercaseString]];
		
		// Add the name to the proper array
		[[sectionArray objectAtIndex:range.location] addObject:remedy];
	}
}
- (void) deselect 
{ 
	[remTable deselectRowAtIndexPath:[remTable indexPathForSelectedRow] animated:YES]; 
} 
- (void)dealloc {
	[sectionArray release];
	[remedyList release];
    [super dealloc];
}


@end
