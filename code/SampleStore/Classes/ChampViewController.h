//
//  ChampViewController.h
//  MyProto
//
//  Created by Rahul on 12/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemTableCustomCell.h"

@interface ChampViewController : UIViewController {
	NSMutableArray *remedyList;
	IBOutlet RemTableCustomCell *tblCell;
	IBOutlet UITableView *remTable;
	NSMutableArray *sectionArray;
}
- (void) createSectionList: (id) remedyArray;
@end
