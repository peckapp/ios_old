//
//  Setting.h
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/7/13.
//  Copyright (c) 2013 stpl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "AppDelegate.h"
#import "CampusEventSubscription.h"
#import "AthleticsSubscription.h"
#import "afterHoursSubscription.h"
#import "AboutUs.h"
#import "ChangePassword.h"
#import "Notification.h"


@class HomeScreen;



@interface Setting : UIViewController<UIScrollViewDelegate>{
 ASIFormDataRequest *facebookuser_logout;
 ASIFormDataRequest *listofdepartments;
    NSMutableArray  *deparmentcount;
    HomeScreen *homescreen;
    CGRect frame;
    BOOL menuOpen;
    UIButton *menuclickbutton;
}
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (assign) BOOL menuOpen;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UITableView *tableview;




- (IBAction)closeSetting:(id)sender;





@end
