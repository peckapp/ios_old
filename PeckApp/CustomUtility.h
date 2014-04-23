//
//  CustomUtility.h
//  PeckApp
//
//  Created by gypsa agarwal on 4/23/13.
//  Copyright (c) 2013 stpl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
@interface CustomUtility : NSObject

@end

@interface UILabel(customize)
- (void)awakeFromNib;
@end
@interface UITextField(customize)
- (void)awakeFromNib;
@end
@interface UITextView(customize)
- (void)awakeFromNib;
@end
@interface UIScrollView(customize)
- (void)awakeFromNib;
@end

@interface UITableView(customize)
- (void)awakeFromNib;

@end



