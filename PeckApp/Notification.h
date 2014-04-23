//
//  Notification.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 7/11/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface Notification : UIViewController
{
 ASIFormDataRequest *getnotification;
 ASIFormDataRequest *submitnotification;
    UIActivityIndicatorView *notificationloading;
}

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UISwitch *Switch;

-(IBAction)closeNotification:(id)sender;
-(IBAction)switchPressed:(id)sender;

@end
