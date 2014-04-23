//
//  AboutUs.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 7/10/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "PeckView.h"

@interface AboutUs : UIViewController<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;


-(IBAction)aboutusclose:(id)sender;
-(IBAction) openpeckurl:(id)sender;
-(IBAction) openmail:(id)sender;

@end
