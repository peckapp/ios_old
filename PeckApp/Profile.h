//
//  Profile.h
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/9/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "AppDelegate.h"
#import "ActionSheet.h"
#import "ImageHelper.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <Twitter/Twitter.h>


@interface Profile : UIViewController<MFMailComposeViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    ASIFormDataRequest *fbuserprofile;
    ASIFormDataRequest *fbuserprofileupdate;
    UITapGestureRecognizer *singleTap;
    BOOL *enterFromPhoto;
}
@property (strong, nonatomic) IBOutlet UIButton *buttonProfileImage;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;

@property (strong, nonatomic) IBOutlet UITextField *username;

@property (strong, nonatomic) IBOutlet UITextField *emailid;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UITextField *phoneno;
@property (strong, nonatomic) IBOutlet UITextField *twittername;
@property (strong, nonatomic) IBOutlet UITextView *aboutDescription;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;

- (IBAction)closeProfile:(id)sender;
- (IBAction)submitProfile:(id)sender;
- (IBAction)btnProfileImageClicked:(id)sender;
- (IBAction) phonecall:(id)sender;
-(IBAction) openmail:(id)sender;
- (IBAction)tweetTapped:(id)sender;
@end
