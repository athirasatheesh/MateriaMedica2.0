//
//  JMSBDBMgrWrapper.m
//  JMSB
//
//  Created by ZCO Engineering Dept on 22/10/09.
//  Copyright 2009 ZCO. All rights reserved.
//

#import "JMSBDBMgrWrapper.h"
#import "RemUtils.h"
#import "Common.h"

@interface JMSBDBMgrWrapper(PRIVATE)
- (void)appendQueryString:(NSString *)fieldName forValue:(NSString *)theValue;
@end
static JMSBDBMgrWrapper *sharedGlobalWrapper = nil;

@implementation JMSBDBMgrWrapper

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
	NSString *theDatabasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kMedicalDatabaseName];
	
	if(!databaseManager){
		// Opens connection to the specified sqlite database
		databaseManager = [[DataBaseManager alloc]initDBWithFileName:theDatabasePath];
	}
}
//	Function	:   sharedWrapper
//	Purpose		:	return shared wrapper instance
//	Parameter	:	nil
//	Return      :	sharedWrapper
+ (JMSBDBMgrWrapper*)sharedWrapper
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

//	Function	:   findAllSessions
//	Purpose		:	find all sessions from sessions table
//	Parameter	:	nil
//	Return      :	array of sessions
- (NSArray*) findAllRemedies
{
	NSArray *sessionArray;
	sessionArray = [databaseManager executeQuery:@"SELECT Distinct NAME FROM tblRemedies order by NAME "];
	return [sessionArray autorelease];
}

//	Function	:   findAllSchedules
//	Purpose		:	find all schedules from Schedules table
//	Parameter	:	nil
//	Return      :	array of schedules
- (NSArray*) findRemedyDetails:(NSString*) theRemedy
{
	NSArray *scheduleArray;
	NSString *query = [NSString stringWithFormat:@"SELECT * FROM tblRemedies WHERE NAME = \'%@\' ",theRemedy];
	scheduleArray = [databaseManager executeQuery:query];
	return [scheduleArray autorelease];
}

- (NSArray*) searchRemediesforMatch:(NSString*) theMatchString forExactMatch: (BOOL) bExactSearch
{
	myQuery =[[NSMutableString alloc] initWithString:@""];
	NSString * newString = @"";
	if (bExactSearch)
	{
		newString = [NSString stringWithFormat:@" %@ ",theMatchString];
	}
	else
	{
		newString = [NSString stringWithFormat:@"%@",theMatchString];
	}
	
	newString = [newString lowercaseString];
	
	NSArray *classArray;

	[myQuery appendFormat:@"Select * from tblRemedies where "];

	for (int index = 1;index < [[RemUtils sharedInstance] arraySize];index++)
	{	
		NSString *keyStr = [NSString stringWithFormat:@"lower(%@)",[[RemUtils sharedInstance]keyStringFromIndex:index]];
		[self appendQueryString:keyStr forValue:newString];
		if (index != [[RemUtils sharedInstance] arraySize]-1)
		{
			[myQuery appendString:@" OR "];
		}
	}
	
	classArray = [databaseManager executeQuery:myQuery];
	[myQuery release];
	return [classArray autorelease];
}
- (void)appendQueryString:(NSString *)fieldName forValue:(NSString *)theValue
{
	
	[myQuery appendFormat:@"%@ like ",fieldName];
	
	NSString *temp = @"'%";
	[myQuery appendString:temp];
	[myQuery appendFormat:@"%@",theValue];	
	[myQuery appendString:@"%'"];
}

@end
