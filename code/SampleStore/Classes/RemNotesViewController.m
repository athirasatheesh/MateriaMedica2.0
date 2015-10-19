//
//  RemNotesViewController.m
//  MyProto
//
//  Created by Rahul on 19/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RemNotesViewController.h"
#import "Common.h"
#import "RemDBMgrNotes.h"
#define K_NOTE_DATA @"Notes"
#define ROW_HEIGHT 130.0f

@implementation RemNotesViewController
@synthesize delegate;

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

	
	UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
																					target:self action:@selector(didSelectSave:)];
	self.navigationItem.rightBarButtonItem = rightBarButton;
	[rightBarButton release];
	
	[noteTable setBackgroundColor:[UIColor blackColor]];
	
	noteNametext.text = noteName;
	noteNametext.backgroundColor = [UIColor clearColor];
	noteNametext.autocorrectionType = UITextAutocorrectionTypeNo;

	noteNametext.clearButtonMode = UITextFieldViewModeWhileEditing;
	if (noteName != nil)
	{
		NSArray * array = [[RemDBMgrNotes sharedWrapper]findNoteDetails:noteName];
		if ([array count] > 0)
		{
			if (noteData)
			{
				[noteData release];
				noteData = nil;
			}
			noteData =   [[[array objectAtIndex:0]objectForKey:K_NOTE_DATA] retain];
			[noteNametext becomeFirstResponder];
		}	
	}
	
}

// Each row array object contains the members for that section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	RemTableCustomNoteCell *cell = (RemTableCustomNoteCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if(cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"RemTableCustomNoteCell" owner:self options:nil];
		cell = tblCell;
	}
	[cell.textView setTextColor:[UIColor blackColor]];
	cell.textView.text = noteData;
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	return cell;
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

- (id)initWithNote:(NSString *)theNoteName andNibName:(NSString *)nibNameOrNil
{
	if (self = [self initWithNibName:nibNameOrNil bundle: nil]) {
        // Custom initialization
		if (theNoteName)
		{
			noteName = [theNoteName retain];
			isAddMode = NO;
		}
		else
		{
			isAddMode = YES;
		}
    }
    return self;
}
- (void)dealloc {
	
	if (noteData)
	{
		[noteData release];
		noteData = nil;
	}
	if (noteName)
	{
		[noteName release];
		noteName = nil;
	}
    [super dealloc];
}

- (void) didSelectBack:(id) sender {
	[delegate cancelMessageDetail];
}
- (void)showRemAlert:(NSString*)theMessage
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iMateriaMedica" message:theMessage 
						delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

- (void) didSelectSave:(id) sender {
	[tblCell.textView  resignFirstResponder];
	[noteNametext resignFirstResponder];
	NSString *currentText = [noteNametext.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if ([currentText isEqualToString:@""] || currentText == nil)
	{
		[self showRemAlert:@"Please enter a note name."];
		return;
	}
	
	if (currentText != nil && isAddMode)
	{
		NSArray * array = [[RemDBMgrNotes sharedWrapper]findNoteDetails:currentText];
		if ([array count] > 0)
		{
			[self showRemAlert:@"Note name exists.Please enter a different name."];
			return;			
		}
	}
	currentText = [tblCell.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if ([currentText isEqualToString:@""] || currentText == nil)
	{
		[self showRemAlert:@"Please enter notes."];
		return;
	}

	if (isAddMode)
	{
		[delegate insertMessageDetail:tblCell.textView.text andName:noteNametext.text];
	}
	else
	{
		[delegate saveMessageDetail:tblCell.textView.text andName:noteNametext.text];
	}
	[self.navigationController popViewControllerAnimated:YES];
}


@end
