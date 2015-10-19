//
//  RemUtils.h
//  SampleStore
//
//  Created by Rahul on 28/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RemUtils : NSObject {
	NSArray *keyArray;
}
+ (RemUtils*)sharedInstance;
- (void)initKeyArray;
- (NSString*) keyStringFromIndex:(NSInteger) theIndex;
- (int) arraySize;
+ (void)releaseSharedInstance;
@end
