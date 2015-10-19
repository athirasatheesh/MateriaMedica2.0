//
//  RemDBMgrNotes.h
//  JMSB
//
//  Created by ZCO Engineering Dept on 22/10/09.
//  Copyright 2009 ZCO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataBaseManager.h"

@interface RemDBMgrNotes : NSObject {
	DataBaseManager *databaseManager;
	NSString *myQuery;
}
+ (RemDBMgrNotes*)sharedWrapper;
- (void)initDBMgr;
- (NSArray*) findAllNotes;
- (NSArray*) findNoteDetails:(NSString*) theNoteName;
- (NSInteger) findIDForNote:(NSString*) theNoteName;
- (BOOL) updateNote:(NSString*) theNoteName andNoteText:(NSString*) theNotetext forID:(NSInteger)theNoteId;
- (BOOL) AddNote:(NSString*) theNoteName andNoteText:(NSString*) theNotetext;
- (BOOL)deleteNote:(NSInteger)theNoteId;
@end
