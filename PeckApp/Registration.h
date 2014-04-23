//
//  Registration.h
//  PeckApp
//
//  Created by STPLINC. on 5/21/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeScreen.h"
#import "Webservices.h"
#import "AppDelegate.h"

@interface Registration : UIViewController<UIAlertViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,ASIHTTPRequestDelegate>
{
    
    ASIFormDataRequest *registration_req;
    ASIFormDataRequest *activation_code_req;
    ASIFormDataRequest *facebookdata_post;
    ASIFormDataRequest *  login_req_facebook;
    ASIFormDataRequest * facebook_email_password_post;
    NSMutableDictionary *dict;
    NSMutableDictionary *dictfacebook;
    UITapGestureRecognizer  *singleTap;
}

@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;

@property (nonatomic, retain) NSMutableDictionary *dict;
@property (nonatomic, retain) ASIFormDataRequest *registration_req;
@property (nonatomic, retain) ASIFormDataRequest *activation_code_req;
@property (strong, nonatomic) IBOutlet UITextField *Username;
@property (strong, nonatomic) IBOutlet UITextField *Emailid;
@property (strong, nonatomic) IBOutlet UITextField *Password;
@property (strong, nonatomic) IBOutlet UITextField *Twittername;
@property (strong, nonatomic) IBOutlet UITextView *Comments;
@property (strong, nonatomic) IBOutlet UITextField *PhoneNo;
@property (strong, nonatomic) IBOutlet UIScrollView *Backgroundscroller;
- (IBAction) registration;
-(IBAction)closeRegistration:(id)sender;
-(IBAction)facebookLoginButtonClick:(id)sender;


@end
