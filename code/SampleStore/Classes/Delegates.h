/*
 *  Delegates.h
 *  SampleStore
 *
 *  Created by Rahul on 28/12/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

@protocol RemNotesTextDetailViewDelegate<NSObject>
- (void) insertMessageDetail:(NSString*) message andName:(NSString*) theName;
- (void) saveMessageDetail:(NSString*) message andName:(NSString*) theName;
- (void) cancelMessageDetail;
@end