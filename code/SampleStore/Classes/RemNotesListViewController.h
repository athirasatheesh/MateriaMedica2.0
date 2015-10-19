//
//  RemNotesListViewController.h
//  SampleStore
//
//  Created by Rahul on 28/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Delegates.h"
#import "RemTableCommonCell.h"

@interface RemNotesListViewController : UIViewController <RemNotesTextDetailViewDelegate> {
	IBOutlet UITableView *notesTable;
	NSMutableArray *notesList;
	IBOutlet RemTableCommonCell *tblCell;
	NSInteger selectedRow;
	NSInteger editingNoteID;
}

@end
