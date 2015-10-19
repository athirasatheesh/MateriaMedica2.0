//
//  RemSearchViewController.h
//  MyProto
//
//  Created by Rahul on 21/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemTableCommonCell.h"

@interface RemSearchViewController : UIViewController {
	IBOutlet UISwitch *matchSwitch;
	NSMutableArray *remedyList;
	IBOutlet UITableView *remTable;
	IBOutlet RemTableCommonCell *tblCell;
	NSString *searchText;
}
- (void) PerformSearch:(NSString *)theSearchText;
@end
