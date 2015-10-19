//
//  RemTableCustomCell.h
//  MyProto
//
//  Created by Rahul on 18/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RemTableCustomCell : UITableViewCell {
	IBOutlet UILabel *remName;
	IBOutlet UIImageView *imageView;
}
@property (nonatomic, retain) IBOutlet UILabel *remName;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@end
