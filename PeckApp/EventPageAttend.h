//
//  EventPageAttend.h
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/8/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ForumPage.h"
#import "CampusEventsViewController.h"
#import "EventAttendingList.h"
#import "circleActivity.h"
#import "ImageHelper.h"

@interface EventPageAttend : UIViewController<UIActivityItemSource>
{
    ASIFormDataRequest *eventdetails;
    ASIFormDataRequest *subscribeevents; 
    NSMutableArray *eventcount;
    CGSize myStringSize;
     CGSize titleSize;
    NSString *newShareText;
     int linesinlocation;
    int linesindepartment;
    int linesindate;
    
       }
@property (strong, nonatomic) IBOutlet UIButton *datebutton;
@property (strong, nonatomic) IBOutlet UIButton *departmentbutton;
@property (strong, nonatomic) IBOutlet UIButton *locationbutton;
@property (strong, nonatomic) IBOutlet UIButton *attendingmembersbutton;
@property (strong, nonatomic) IBOutlet UIImageView *departmentimage;
@property (strong, nonatomic) IBOutlet UIImageView *attendmemberimage;
@property (strong, nonatomic) IBOutlet UIImageView *locationimage;
@property (strong, nonatomic) IBOutlet UIImageView *clockimage;
@property (strong, nonatomic) IBOutlet UIView *thirdlineview;
@property (strong, nonatomic) IBOutlet UIView *secondlineview;
@property (strong, nonatomic) IBOutlet UIView *firstlineview;

@property (strong, nonatomic) IBOutlet UIView *lastlineview;
@property (strong, nonatomic) IBOutlet UIButton *updateEvent;

@property (strong, nonatomic) IBOutlet UIView *readmorebuttonview;
@property (strong, nonatomic) IBOutlet UIButton *readmoreTitleButton;
@property (strong, nonatomic) IBOutlet UIScrollView *Backgroundscroller;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic)  NSMutableArray *eventcount;
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *eventAttending;
@property (strong, nonatomic) IBOutlet UILabel *eventLocation;

@property (strong, nonatomic) IBOutlet UILabel *dateAndTime;
@property (strong, nonatomic) IBOutlet UIButton *attendEventBtn;
@property (strong, nonatomic) IBOutlet UITextView *commentTextView;
@property (strong, nonatomic) IBOutlet UIImageView *eventImage;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIButton *readmoreButton;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;


-(IBAction) EventsPageButtonClosed:(id)sender;
-(IBAction) attendEvent:(id)sender;
-(IBAction) forumPageOpen:(id)sender;
-(IBAction) eventAttendingMembers:(id)sender;
-(IBAction) share:(id)sender;
-(IBAction) readmore:(id)sender;
-(IBAction) readmoreTitle:(id)sender;
-(IBAction) readmorelocation:(id)sender;
-(IBAction) readmoredepartment:(id)sender;
-(IBAction) readmoredate:(id)sender;
-(IBAction) editEvents:(id)sender;

@end
