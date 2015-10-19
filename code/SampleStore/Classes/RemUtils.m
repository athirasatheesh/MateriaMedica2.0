//
//  RemUtils.m
//  SampleStore
//
//  Created by Rahul on 28/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


#import "RemUtils.h"
#import "Common.h"
static RemUtils *sharedGlobalInstance = nil;

@implementation RemUtils
+ (RemUtils*)sharedInstance
{
	@synchronized(self) {
        if (sharedGlobalInstance == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return sharedGlobalInstance;
}
+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedGlobalInstance == nil) {
            sharedGlobalInstance = [super allocWithZone:zone];
            return sharedGlobalInstance;  // assignment and return on first allocation
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
- (id)autorelease
{
    return self;
}
- (NSString*) keyStringFromIndex:(NSInteger) theIndex
{
	return [keyArray objectAtIndex:theIndex];
}
-(id)init
{
	if(self = [super init])
	{
		[self initKeyArray];
	}
	return self;
}

- (int) arraySize
{
	return [keyArray count];
}
- (void)initKeyArray
{
	if (keyArray == nil)
	{
		keyArray = [[NSArray alloc] initWithObjects: KEY_LIST, nil]; 
	}
}
+ (void)releaseSharedInstance
{
	if(sharedGlobalInstance)
	{
		[sharedGlobalInstance release];
	}
}

@end
