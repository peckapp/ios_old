//
//  AthleticsEventPage.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 6/5/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AthleticForumPage.h"
#import "circleActivity.h"
@interface AthleticsEventPage : UIViewController<UIActivityItemSource>
{
    
    UITapGestureRecognizer  *singleTap;
    ASIFormDataRequest *athleticdetails;
     ASIFormDataRequest *subscribeevents; 
    NSMutableArray *eventcount;
     CGSize myStringSize;
    CGSize titleSize;
    CGSize titleSizeOpponent;
    int linesinopponent;
   NSString *newShareText;
   int linesinlocation;
    int linesindate;
}
@property (strong, nonatomic) IBOutlet UIButton *readmoreButton;

@property (strong, nonatomic) IBOutlet UIButton *datebutton;
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

@property (strong, nonatomic) IBOutlet UIView *allDescriptionView;
@property (strong, nonatomic) IBOutlet UIButton *readmoreOpponentButton;
@property (strong, nonatomic) IBOutlet UILabel *InandFinalTitle;
@property (strong, nonatomic) IBOutlet UILabel *williamsLabel;
@property (strong, nonatomic) IBOutlet UILabel *opponentLabel;
@property (strong, nonatomic) IBOutlet UIView *readmorebuttonview;
@property (strong, nonatomic) IBOutlet UIButton *readmoreTitleButton;

@property (strong, nonatomic) IBOutlet UIScrollView *Backgroundscroller;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutlet UILabel *opponentScore;

@property (strong, nonatomic) IBOutlet UILabel *universityScore;

@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *eventAttending;
@property (strong, nonatomic) IBOutlet UILabel *eventLocation;
@property (strong, nonatomic) IBOutlet UITextView *commentTextView;


@property (strong, nonatomic) IBOutlet UILabel *dateAndTime;
@property (strong, nonatomic)   NSMutableArray *eventcount;
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIButton *attendEventBtn;


-(IBAction)atheleticsEventsClosed:(id)sender;
-(IBAction)attendEvent:(id)sender;
-(IBAction)forumPageOpen:(id)sender;
-(IBAction)share:(id)sender;
-(IBAction) eventAttendingMembers:(id)sender;
- (IBAction)readmore:(id)sender;
-(IBAction) readmoreTitle:(id)sender;
-(IBAction) readmoreOpponent:(id)sender;
-(IBAction) readmorelocation:(id)sender;
-(IBAction) readmoredate:(id)sender;
@end
