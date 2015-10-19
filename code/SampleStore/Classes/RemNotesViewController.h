//
//  RemNotesViewController.h
//  MyProto
//
//  Created by Rahul on 19/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Delegates.h"
#import "RemTableCustomNoteCell.h"

@interface RemNotesViewController : UIViewController {
	NSString *noteName;
	IBOutlet UITextField *noteNametext;
	NSString *noteData;
	IBOutlet UITableView *noteTable;
	IBOutlet RemTableCustomNoteCell *tblCell;
	UIButton *backButton, *saveButton;
	id<RemNotesTextDetailViewDelegate> delegate;
	BOOL isAddMode;
}
@property(assign, nonatomic, readwrite) id<RemNotesTextDetailViewDelegate> delegate;
- (id)initWithNote:(NSString *)theNoteName andNibName:(NSString *)nibNameOrNil;
- (void) didSelectBack:(id) sender;
- (void) didSelectSave:(id) sender;
@end
