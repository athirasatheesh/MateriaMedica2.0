//
//  RemTableCustomNoteCell.h
//  MyProto
//
//  Created by Rahul on 18/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RemTableCustomNoteCell : UITableViewCell {
	IBOutlet UITextView *textView;
}
@property (nonatomic, retain) IBOutlet UITextView *textView;

@end
