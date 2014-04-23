//
//  ViewProfile.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 6/10/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <Twitter/Twitter.h>


@interface ViewProfile :UIViewController<MFMailComposeViewControllerDelegate>

{
    
    ASIFormDataRequest *viewprofile;
  
    
}
@property (strong, nonatomic) IBOutlet UITextField *username;

@property (strong, nonatomic) IBOutlet UITextField *emailid;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;


@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UITextField *phoneno;
@property (strong, nonatomic) IBOutlet UITextField *twittername;
@property (strong, nonatomic) IBOutlet UITextView *aboutDescription;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;

- (IBAction)closeProfile:(id)sender;
- (IBAction) phonecall:(id)sender;
-(IBAction) openmail:(id)sender;
@end
