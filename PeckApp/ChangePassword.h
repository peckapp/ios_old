//
//  ChangePassword.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 9/13/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Webservices.h"

@interface ChangePassword : UIViewController
{
    UITapGestureRecognizer  *singleTap;
     ASIFormDataRequest *changepassword;
}
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UITextField *oldpassword;
@property (strong, nonatomic) IBOutlet UITextField *newpassword;
@property (strong, nonatomic) IBOutlet UITextField *confirmpassword;



-(IBAction)closeChangePassword:(id)sender;

@end
