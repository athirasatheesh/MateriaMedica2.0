//
//  RemNotesListViewController.m
//  SampleStore
//
//  Created by Rahul on 28/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RemNotesListViewController.h"
#import "Common.h"
#import "RemDBMgrNotes.h"
#import "RemNotesViewController.h"

#define ROW_HEIGHT 44.0f

#define K_NOTE_NAME @"Name"

@implementation RemNotesListViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/
//////////////////////////////////////////////////////////////////////////////////////////////
// Purpose    : Toggle left bar item by toggling text when mode is changed to edit 
// Parameters : editing mode
// Return type: nil
// Comments   :	nil
//////////////////////////////////////////////////////////////////////////////////////////////
- (void)toggleLeftBarButtonEditing: (BOOL)editing
{	
	UIBarButtonItem *barButton;
	if(editing)
	{
		barButton =  [[UIBarButtonItem alloc]
					  initWithTitle:@"Done" 
					  style:UIBarButtonItemStylePlain 
					  target:self 
					  action:@selector(leaveEditMode)];	
	}
	else
	{
		barButton =  [[UIBarButtonItem alloc]
					  initWithTitle:@"Edit" 
					  style:UIBarButtonItemStylePlain 
					  target:self 
					  action:@selector(enterEditMode)];
	}
	self.navigationItem.leftBarButtonItem = barButton;
	[barButton release];
}
//////////////////////////////////////////////////////////////////////////////////////////////
// Purpose    : Enter edit mode by changing "Edit" to "Done"
// Parameters : nil
// Return type: nil
// Comments   :	nil
//////////////////////////////////////////////////////////////////////////////////////////////
- (void)enterEditMode 
{ 
	[self toggleLeftBarButtonEditing: YES];
	self.navigationItem.rightBarButtonItem.enabled=NO;
	[notesTable setEditing:YES animated:YES];
	[notesTable reloadData];
}

//////////////////////////////////////////////////////////////////////////////////////////////
// Purpose    : Enter edit mode by changing "Edit" to "Done" 
// Parameters : nil
// Return type: nil
// Comments   :	nil
//////////////////////////////////////////////////////////////////////////////////////////////
- (void)leaveEditMode 
{ 
	self.navigationItem.rightBarButtonItem.enabled=YES;
	[self toggleLeftBarButtonEditing: NO];
	[notesTable setEditing:NO animated:YES];
	[notesTable reloadData];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationController.navigationBar.tintColor = defaulttintcolor;
	[notesTable setBackgroundColor:[UIColor blackColor]];
	
	
	// left bar button setup
	[self toggleLeftBarButtonEditing: NO];
	//	right bar button setup
	UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNote)];
	self.navigationItem.rightBarButtonItem = rightBarButton;
	[rightBarButton release];

	
	//[notesTable setBackgroundColor: [UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1]];
	if(!notesList)
	{
		notesList = [[NSMutableArray alloc]init];
	}
	NSArray *notesArray = [[RemDBMgrNotes sharedWrapper] findAllNotes];
	if ([notesArray count] > 0)
	{
		for (int index = 0; index < [notesArray count]; index++) 
		{
			NSString *noteName = [[notesArray objectAtIndex:index]objectForKey:K_NOTE_NAME];
			if (noteName)
			{
				[notesList addObject:noteName];
			}
		}
	}
}

- (void) addNote
{
	
	RemNotesViewController *noteViewController = nil;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
	{
		noteViewController = [[RemNotesViewController alloc]initWithNote:nil andNibName:@"RemNotesViewController-iPad"];
	} 
	else 
	{
		noteViewController = [[RemNotesViewController alloc]initWithNote:nil andNibName:@"RemNotesViewController"];
	}

	noteViewController.delegate = self;
	[self.navigationController pushViewController:noteViewController animated:YES];

	[noteViewController release];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [notesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
//	UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//	if(cell == nil) {
//		cell = [[[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 0, 0) reuseIdentifier:CellIdentifier]autorelease];
//	}
	RemTableCommonCell *cell = (RemTableCommonCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if(cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"RemTableCommonCell" owner:self options:nil];
		cell = tblCell;
	}
	//// imagebackdrnd
	NSString *bgImageName = @"";
	bgImageName = [NSString stringWithString:TABLE_MIDDLE_ROW_IMAGE_NAME];
	
	/*if([notesTable numberOfRowsInSection:indexPath.section] == 1){
		bgImageName = [NSString stringWithString:TABLE_SINGLE_ROW_IMAGE_NAME];
	}
	else
	{
		if (indexPath.row == 0)
		{
			bgImageName = [NSString stringWithString:TABLE_TOP_ROW_IMAGE_NAME];
			
		}
		else if (indexPath.row == ([notesTable numberOfRowsInSection:indexPath.section] - 1)) 
		{
			bgImageName = [NSString stringWithString:TABLE_BOTTOM_ROW_IMAGE_NAME];
			
		}
		else
		{
			bgImageName = [NSString stringWithString:TABLE_MIDDLE_ROW_IMAGE_NAME];
			
		}
	}	
	 */
	////
	UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:cell.frame];//initWithImage:[UIImage imageNamed:@"CellBg.png"]];
	backgroundImageView.image = [UIImage imageNamed:bgImageName];
	
	
	cell.backgroundView = backgroundImageView;
	[backgroundImageView release];
	[cell.remName setTextColor:[UIColor whiteColor]];
	cell.remName.text = [notesList objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	selectedRow = indexPath.row;
	editingNoteID = [[RemDBMgrNotes sharedWrapper]findIDForNote:[notesList objectAtIndex:indexPath.row]];

	
	RemNotesViewController *noteViewController = nil;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
	{
		noteViewController = [[RemNotesViewController alloc]initWithNote:[notesList objectAtIndex:indexPath.row] andNibName:@"RemNotesViewController-iPad"];
	} 
	else 
	{
		noteViewController = [[RemNotesViewController alloc]initWithNote:[notesList objectAtIndex:indexPath.row] andNibName:@"RemNotesViewController"];
	}

	
	noteViewController.delegate = self;
	[[self navigationController]pushViewController:noteViewController animated:YES];
	[noteViewController release];
	[self performSelector:@selector(deselect) withObject:NULL afterDelay:0.5]; 
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	return ROW_HEIGHT;
}
// One section for each alphabet member
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}
- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle  forRowAtIndexPath: (NSIndexPath *)indexPath 

{
	editingNoteID = [[RemDBMgrNotes sharedWrapper]findIDForNote:[notesList objectAtIndex:indexPath.row]];
	[[RemDBMgrNotes sharedWrapper]deleteNote:editingNoteID];
	[notesList removeObjectAtIndex:indexPath.row];
	[notesTable reloadData];
}
- (void) deselect 
{ 
	[notesTable deselectRowAtIndexPath:[notesTable indexPathForSelectedRow] animated:YES]; 
	
} 
- (void)dealloc {
	[notesList release];
    [super dealloc];
}
- (void) saveMessageDetail:(NSString*) message andName:(NSString*) theName
{
	[notesList replaceObjectAtIndex:selectedRow withObject:theName];
	
	[[RemDBMgrNotes sharedWrapper] updateNote:theName andNoteText:message forID:editingNoteID];
	[notesTable reloadData];
}
- (void) cancelMessageDetail
{
}
- (void) insertMessageDetail:(NSString*) message andName:(NSString*) theName
{
	[[RemDBMgrNotes sharedWrapper] AddNote:theName andNoteText:message];

	[notesList addObject:theName];
	[notesTable reloadData];
}
@end
