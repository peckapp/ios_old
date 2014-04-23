//
//  CustomUtility.m
//  PeckApp
//
//  Created by gypsa agarwal on 4/23/13.
//  Copyright (c) 2013 stpl. All rights reserved.
//

#import "CustomUtility.h"

@implementation CustomUtility

@end
@implementation UILabel(customize)
- (void)awakeFromNib
{
    [super awakeFromNib];
  
[self setFont:[UIFont fontWithName:@"Lato-Regular" size:self.font.pointSize]];
    
}
@end
@implementation UITextField(customize)
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius=4.0;
    [self setFont:[UIFont fontWithName:@"Lato-Regular" size:self.font.pointSize]];
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.autocorrectionType=FALSE;
    
   }
@end

@implementation UITextView(customize)
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius=4.0;
     self.autocapitalizationType = UITextAutocapitalizationTypeNone;
     self.autocorrectionType=FALSE;
    [self setFont:[UIFont fontWithName:@"Lato-Regular" size:self.font.pointSize]];
    
}


@end


@implementation UIButton(customize)
- (void)awakeFromNib{
    [super awakeFromNib];
    //self.layer.cornerRadius=4.0;
   self.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:self.titleLabel.font.pointSize];

}
@end

@implementation UIScrollView(customize)
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.showsVerticalScrollIndicator=NO;
    
}
@end
@implementation UITableView(customize)
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.showsVerticalScrollIndicator=NO;
    
    
}
@end





