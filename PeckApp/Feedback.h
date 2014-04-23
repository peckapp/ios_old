//
//  Feedback.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 9/23/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "AppDelegate.h"

@interface Feedback : UIViewController
{

   UITapGestureRecognizer   *singleTap;
    ASIFormDataRequest *feedback;
    HomeScreen *homescreen;
    CGRect frame;
    BOOL menuOpen;
    UIButton *menuclickbutton;
}

-(IBAction) closeFeedback:(id)sender;
-(IBAction) submitFeedback:(id)sender;




@property (strong, nonatomic) IBOutlet UIScrollView *backGroundView;

@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;

@property (strong, nonatomic) IBOutlet UITextView *commentTextView;

@end
