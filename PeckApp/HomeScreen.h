//
//  HomeScreen.h
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/3/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Setting.h"
#import "Circles.h"
#import "MyHorizon.h"
#import "Activity.h"
#import "Athletics.h"
#import "Dining.h"
#import "CampusEventsViewController.h"
#import "afterHours.h"
#import "Feedback.h"


@interface HomeScreen : UIViewController
{


}
@property (strong, nonatomic) IBOutlet UILabel *testlabel;
@property (strong, nonatomic) IBOutlet UILabel *NotificationCount;
@property (strong, nonatomic) IBOutlet UIButton *settings;
@property (strong, nonatomic) IBOutlet UIButton *feedback;
@property (strong, nonatomic) IBOutlet UIButton *circles;
@property (strong, nonatomic) IBOutlet UIButton *dining;
@property (strong, nonatomic) IBOutlet UIButton *activity;
@property (strong, nonatomic) IBOutlet UIButton *afterHours;
@property (strong, nonatomic) IBOutlet UIButton *campusEvents;
@property (strong, nonatomic) IBOutlet UIButton *athletics;

@property (strong, nonatomic) IBOutlet UIView *animatedView;
@property (strong, nonatomic) IBOutlet UIButton *myhorizon;
@property (strong, nonatomic) IBOutlet UIScrollView *Backgroundscroller;
@property (strong, nonatomic) IBOutlet UILabel *myHorizonLabel;


-(IBAction) campusEventsButtonClicked:(id)sender;
-(IBAction)settingClicked:(id)sender;
-(IBAction)circleClicked:(id)sender;
-(IBAction) myHorizonClicked:(id)sender;
-(IBAction)activityClicked:(id)sender;
-(IBAction)atheleticsClicked:(id)sender;
-(IBAction)diningClicked:(id)sender;
-(IBAction)afterHoursClicked:(id)sender;
- (IBAction)openFeedback:(id)sender;

@end
