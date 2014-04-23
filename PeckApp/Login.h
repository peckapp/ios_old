//
//  Login.h
//  PeckApp
//
//  Created by STPLINC. on 5/21/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeScreen.h"
#import "MyHorizon.h"
#import "Webservices.h"
#import "AppDelegate.h"

@interface Login : UIViewController<UIAlertViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,ASIHTTPRequestDelegate>
{
    
    ASIFormDataRequest *login_req;
    ASIFormDataRequest *login_req_facebook;
    ASIFormDataRequest *activation_code_req;
    ASIFormDataRequest *facebookdata_post;
    ASIFormDataRequest *facebook_email_password_post;
    ASIFormDataRequest *forgotpassword;
    NSMutableDictionary *dict;
    NSMutableDictionary *dictfacebook;
    UITapGestureRecognizer  *singleTap;
   
}
-(IBAction)facebookLoginButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;


@property (nonatomic, retain) NSMutableDictionary *dict;
@property (nonatomic, retain) ASIFormDataRequest *login_req;
@property (nonatomic, retain) ASIFormDataRequest *activation_code_req;
@property (nonatomic, retain) ASIFormDataRequest *facebookdata_post;
@property (strong, nonatomic) IBOutlet UITextField *Emailid;
@property (strong, nonatomic) IBOutlet UITextField *Password;
@property (strong, nonatomic) IBOutlet UIScrollView *Backgroundscroller;
- (IBAction)login;
-(IBAction)closeLogin:(id)sender;
-(IBAction)forgotPasswordClick:(id)sender;
- (IBAction)singleTapGesture:(UITextField *) textField;

@end
