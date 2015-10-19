//
//  RemViewController.m
//  MyProto
//
//  Created by Rahul on 17/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RemViewController.h"
#import "JMSBDBMgrWrapper.h"
#import "Common.h"
#import "RemUtils.h"

@implementation RemViewController
@synthesize webView;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}


- (id)initWithRemedy:(NSString *)remName andSearchString:(NSString *)theSearchString  andExactMatch:(BOOL) theExactMatch
{
	if (self = [super init]) {
        // Custom initialization
		remedyName = remName;
		searchString = theSearchString;
		bExactMatch = theExactMatch;
    }
    return self;
}
-(BOOL)copyhtmlFromResourceToDocumentsDirectory{
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filepath = [documentsDirectory stringByAppendingPathComponent:HTML_FILE];
	
	success = [fileManager fileExistsAtPath:filepath];
	
	if (success) 
	{
		success =  [fileManager removeItemAtPath:filepath error:&error];
	}	
	NSString *defaultPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:HTML_FILE];
	
	success = [fileManager copyItemAtPath:defaultPath toPath:filepath error:&error];
	return success;
}

//- (NSString *)appendHtmlData:(NSString *)target withString:(NSString *) theValue
//{
//	[target stringByAppendingFormat:@"document.write( <h2> %@ </h2>);",theValue];
//	htmlString = [htmlString stringByReplacingOccurrencesOfString:TAG_NAME withString:theValue];
//}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = remedyName;
	[webView setBackgroundColor:[UIColor grayColor]];
	[self copyhtmlFromResourceToDocumentsDirectory]; 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filepath = [documentsDirectory stringByAppendingPathComponent:HTML_FILE];

	htmlString = [[NSMutableString alloc]initWithContentsOfFile:filepath];
	
	NSArray * array = [[JMSBDBMgrWrapper sharedWrapper] findRemedyDetails:remedyName];
	if ([array count] > 0)
	{
		[htmlString replaceOccurrencesOfString:TAG_NAME withString:remedyName options:0 range:NSMakeRange(0, [htmlString length])];
	
		NSString *subheading =  [[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_SUBH]];
		subheading = [subheading stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
		subheading = [subheading stringByReplacingOccurrencesOfString:@"\"" withString:@"\'"];
		if (subheading)
		{
			[htmlString replaceOccurrencesOfString:TAG_SUBH withString:subheading  options:0 range:NSMakeRange(0, [htmlString length])];
		}
		NSString *generaldesc = [[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_GENERAL]]; 
		generaldesc = [generaldesc stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
		generaldesc = [generaldesc stringByReplacingOccurrencesOfString:@"\"" withString:@"\'"];
		if (generaldesc)
		{
			[htmlString replaceOccurrencesOfString:TAG_GENERAL withString:generaldesc  options:0 range:NSMakeRange(0, [htmlString length])];
		}
		// append datas
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_MIND]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_MIND]];
	
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_NERVES]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_NERVES]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_HEAD]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_HEAD]];

		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_FACE]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_FACE]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_EYES]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_EYES]];
	
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_EARS]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_EARS]];

		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_NOSE]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_NOSE]];

		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_MOUTH]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_MOUTH]];

		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_THROAT]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_THROAT]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_HEART]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_HEART]];

		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_CHEST]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_CHEST]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_STOMACH]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_STOMACH]];

		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_LIVER]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_LIVER]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_KIDNEY]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_KIDNEY]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RECTUM]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RECTUM]];

		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_URINARY]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_URINARY]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_URIN_PART]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_URIN_PART]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RESPIRATORY]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RESPIRATORY]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_EXTREMETIES]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_EXTREMETIES]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_SKIN]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_SKIN]];

		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_TISSUES]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_TISSUES]];
	
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_MALE]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_MALE]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_FEMALE]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_FEMALE]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_SEXUAL]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_SEXUAL]];

		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_FEVER]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_FEVER]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_BACK]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_BACK]];

		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_STOOL]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_STOOL]];
	
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_SLEEP]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_SLEEP]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_MODALITIES]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_MODALITIES]];
	
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_USES]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_USES]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RGENERAL]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RGENERAL]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RCOMPARE]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RCOMPARE]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RCOMPLIMENT]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RCOMPLIMENT]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RANTIDOTE]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RANTIDOTE]];
		///// new on 29 01 2010
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RCOMPATIBLE]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RCOMPATIBLE]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RINIMICAL]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RINIMICAL]];
		
		//// new items  21- JAN -10

		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RINCOMPATIBLE]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_RINCOMPATIBLE]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_BONES]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_BONES]];

		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_TONGUE]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_TONGUE]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_CIRCULATORY]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_CIRCULATORY]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_BLOOD]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_BLOOD]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_SPINE]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_SPINE]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_BOWELS]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_BOWELS]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_TEETH]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_TEETH]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_BREAST]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_BREAST]];


		///

		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_GASTRO]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_GASTRO]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_SPLEEN]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_SPLEEN]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_NECK]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_NECK]];

		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_AILMENTARY_CANAL]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_AILMENTARY_CANAL]];

		/////
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_PHYSIO_DOSAGE]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_PHYSIO_DOSAGE]];
		
		[self appendStringToHTML:[[array objectAtIndex:0]objectForKey:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_DOSE]] 
						  forTag:[[RemUtils sharedInstance]keyStringFromIndex:K_INDEX_DOSE]];
		// footer
		[htmlString appendFormat:@"</script>\n</body>\n</html>"];
		[self setHighLighting];
		[webView loadHTMLString:htmlString baseURL:nil];
	}
	//NSLog(@"Log ----> %@ ",htmlString);
}

- (void)setHighLighting
{
	if (htmlString && searchString)
	{
		NSString *localString = nil;
		NSString *newString = nil;
		if (bExactMatch)
		{
			// put one space
			localString = [[NSString alloc]initWithFormat:@" %@ ",searchString];
			newString =  [[NSString alloc]initWithFormat:@" %@ ",[searchString stringByReplacingCharactersInRange:NSMakeRange(0,1) 
																								 withString:[[searchString substringToIndex:1] capitalizedString]]];
		}
		else
		{
			localString =[[NSString alloc]initWithString:searchString];
			// if found the search string
			newString = [[NSString alloc]initWithString:[searchString stringByReplacingCharactersInRange:NSMakeRange(0,1) 
																						 withString:[[searchString substringToIndex:1] capitalizedString]]];
		}

//		NSLog(@"the search string exact searchstring ----> <%@>",localString);
		if ([htmlString rangeOfString:localString].length > 0)
		{
			NSString *replaceText = [[NSString alloc]initWithFormat:@"<font size=3 face=Verdana color = red>%@</font>",localString];
			[htmlString replaceOccurrencesOfString:localString withString:replaceText options:NSLiteralSearch range:NSMakeRange(0, [htmlString length])];
			[replaceText release];
		}
		// first capital case for search string
//		NSLog(@"the search string exact newstring ----> <%@>",newString);
		if ([htmlString rangeOfString:newString].length > 0)
		{
			NSString *replaceText = [[NSString alloc]initWithFormat:@"<font size=3 face=Verdana color = red>%@</font>",newString];
			[htmlString replaceOccurrencesOfString:newString withString:replaceText options:NSLiteralSearch range:NSMakeRange(0, [htmlString length])];
			[replaceText release];
		}
		[localString release];
		[newString release];
	}
}
- (void)appendStringToHTML:(NSString *)remData forTag:(NSString *)tagName
{
	remData = [remData stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
	remData = [remData stringByReplacingOccurrencesOfString:@"\"" withString:@"\'"];
	
	if (remData && ![remData isEqualToString:@""] && ![tagName isEqualToString:@""] && ![remData isEqualToString:@"null"] )
	{	
		if ([tagName isEqualToString:@"Rcompare"] || [tagName isEqualToString:@"Rcompliment"] || [tagName isEqualToString:@"Rantidote"] 
			|| [tagName isEqualToString:@"Rgeneral"] || [tagName isEqualToString:@"Rincompatible"] || [tagName isEqualToString:@"Rcompatible"] ||
			[tagName isEqualToString:@"Rinimical"])
		{
			if (![htmlString rangeOfString:@"Relationship"].length > 0)
			{
				[htmlString appendFormat:@"document.write( %@ %@ %@",@"\"<h3>" ,@"Relationship",@"</h3>\");\n"];
			}
//			if ([tagName isEqualToString:@"Rgeneral"])
//			{
//				[htmlString appendFormat:@"document.write( %@ %@ %@",@"\"<h4>" ,@"General",@"</h4>\");\n"];
//			}
			if ([tagName isEqualToString:@"Rcompare"])
			{
				[htmlString appendFormat:@"document.write( %@ %@ %@",@"\"<h4>" ,@"Compare",@"</h4>\");\n"];
			}
			if ([tagName isEqualToString:@"Rcompliment"])
			{
				[htmlString appendFormat:@"document.write( %@ %@ %@",@"\"<h4>" ,@"Compliment",@"</h4>\");\n"];
			}
			if ([tagName isEqualToString:@"Rantidote"])
			{
				[htmlString appendFormat:@"document.write( %@ %@ %@",@"\"<h4>" ,@"Antidotes",@"</h4>\");\n"];
			}
			if ([tagName isEqualToString:@"Rincompatible"])
			{
				[htmlString appendFormat:@"document.write( %@ %@ %@",@"\"<h4>" ,@"Incompatible",@"</h4>\");\n"];
			}
			if ([tagName isEqualToString:@"Rcompatible"])
			{
				[htmlString appendFormat:@"document.write( %@ %@ %@",@"\"<h4>" ,@"Compatible",@"</h4>\");\n"];
			}
			if ([tagName isEqualToString:@"Rinimical"])
			{
				[htmlString appendFormat:@"document.write( %@ %@ %@",@"\"<h4>" ,@"Inimical",@"</h4>\");\n"];
			}
		}
		else if ([tagName isEqualToString:@"PhysiologicDosage"] || [tagName isEqualToString:@"AlimentaryCanal"])
		{
			if ([tagName isEqualToString:@"PhysiologicDosage"])
			{
				[htmlString appendFormat:@"document.write( %@ %@ %@",@"\"<h3>" ,@"Physiological Dosage",@"</h3>\");\n"];
			}
			if ([tagName isEqualToString:@"AlimentaryCanal"])
			{
				[htmlString appendFormat:@"document.write( %@ %@ %@",@"\"<h3>" ,@"Alimentary Canal",@"</h3>\");\n"];
			}
		}
		else
		{
			[htmlString appendFormat:@"document.write( %@ %@ %@",@"\"<h3>" ,tagName,@"</h3>\");\n"];
		}
		[htmlString appendFormat:@"document.write( %@ %@ %@",@"\"<p>" ,remData,@"</p>\");\n"];
	}
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	//self.webView = nil;
}


- (void)dealloc {
	[htmlString release];
	[webView release];
	[super dealloc];
}


@end
