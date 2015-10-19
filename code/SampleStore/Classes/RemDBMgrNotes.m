//
//  RemDBMgrNotes.m
//  JMSB
//
//  Created by ZCO Engineering Dept on 22/10/09.
//  Copyright 2009 ZCO. All rights reserved.
//

#import "RemDBMgrNotes.h"
#import "RemUtils.h"
#import "Common.h"

static RemDBMgrNotes *sharedGlobalWrapper = nil;

@implementation RemDBMgrNotes

-(id)init
{
	if(self = [super init])
	{
		[self initDBMgr];
	}
	return self;
}
//	Function	:   initDBMgr
//	Purpose		:	Opens JMSB DB sqlite 
//	Parameter	:	nil
//	Return      :	nil
- (void)initDBMgr
{
//	NSString *theDatabasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kDatabaseName];

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *theDatabasePath = [documentsDirectory stringByAppendingPathComponent:kNotesDatabaseName];
	
	if(!databaseManager){
		// Opens connection to the specified sqlite database
		databaseManager = [[DataBaseManager alloc]initDBWithFileName:theDatabasePath];
	}
}
//	Function	:   sharedWrapper
//	Purpose		:	return shared wrapper instance
//	Parameter	:	nil
//	Return      :	sharedWrapper
+ (RemDBMgrNotes*)sharedWrapper
{
	@synchronized(self) {
        if (sharedGlobalWrapper == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return sharedGlobalWrapper;
	
}
+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedGlobalWrapper == nil) {
            sharedGlobalWrapper = [super allocWithZone:zone];
            return sharedGlobalWrapper;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX;  //denotes an object that cannot be released
}

- (void)release
{
	if(databaseManager)
	{
		[databaseManager close];
		[databaseManager  release];
		databaseManager = nil;
	}
}

- (id)autorelease
{
    return self;
}


- (NSArray*) findAllNotes
{
	NSArray *notesArray;
	notesArray = [databaseManager executeQuery:@"SELECT Distinct NAME FROM tblNotes order by NoteId"];
	return [notesArray autorelease];
}
- (BOOL)deleteNote:(NSInteger)theNoteId
{
	BOOL success = NO;
	NSMutableArray *argsArray = [[NSMutableArray alloc] init];
	NSString *cmd = @"Delete From tblNotes where NoteId = ?";
	
	[argsArray addObject:[NSNumber numberWithInt:theNoteId]];
	// Execute the insert query with array of values as parameter
	success = [databaseManager executeNonQuery:cmd arguments:argsArray];
	[argsArray release];
	
	return success;
}
- (BOOL) updateNote:(NSString*) theNoteName andNoteText:(NSString*) theNotetext forID:(NSInteger)theNoteId
{
	BOOL success = NO;
	NSMutableArray *argsArray = [[NSMutableArray alloc] init];
	NSString *cmd = @"Update tblNotes set Name = ?, Notes = ? where NoteId = ?";
	
	[argsArray addObject:theNoteName];
	[argsArray addObject:theNotetext];
	[argsArray addObject:[NSNumber numberWithInt:theNoteId]];
	// Execute the insert query with array of values as parameter
	success = [databaseManager executeNonQuery:cmd arguments:argsArray];
	[argsArray release];
	
	return success;
	
}
- (BOOL) AddNote:(NSString*) theNoteName andNoteText:(NSString*) theNotetext
{
	BOOL success = NO;
	NSMutableArray *argsArray = [[NSMutableArray alloc] init];
	NSString *cmd = @"INSERT INTO tblNotes (Name, Notes) VALUES(?,?)";
	
	[argsArray addObject:theNoteName];
	[argsArray addObject:theNotetext];
	
	// Execute the insert query with array of values as parameter
	success = [databaseManager executeNonQuery:cmd arguments:argsArray];
	[argsArray release];

	return success;
	
}
- (NSInteger) findIDForNote:(NSString*) theNoteName
{
	NSInteger noteId = 0;
	NSArray *notesArray;
	NSString *query = [NSString stringWithFormat:@"SELECT NoteId FROM tblNotes where NAME = \'%@\' ",theNoteName];
	notesArray = [databaseManager executeQuery:query];

	if ([notesArray count] > 0)
	{
		NSDictionary *dict = [notesArray objectAtIndex:0];
		noteId = [[dict objectForKey:@"NoteId"]intValue];
	}
	[notesArray release];
	return noteId;
}


- (NSArray*) findNoteDetails:(NSString*) theNoteName
{
	NSArray *noteDataArray;
	NSString *query = [NSString stringWithFormat:@"SELECT * FROM tblNotes WHERE NAME = \'%@\' ",theNoteName];
	noteDataArray = [databaseManager executeQuery:query];
	return [noteDataArray autorelease];
}

@end
