//
//  JMSBDBMgrWrapper.h
//  JMSB
//
//  Created by ZCO Engineering Dept on 22/10/09.
//  Copyright 2009 ZCO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataBaseManager.h"

@interface JMSBDBMgrWrapper : NSObject {
	DataBaseManager *databaseManager;
	NSMutableString *myQuery;
}
+ (JMSBDBMgrWrapper*)sharedWrapper;
- (void)initDBMgr;
- (NSArray*) findAllRemedies;
- (NSArray*) findRemedyDetails:(NSString*) theRemedy;
- (NSArray*) searchRemediesforMatch:(NSString*) theMatchString forExactMatch: (BOOL) bExactSearch;
@end
