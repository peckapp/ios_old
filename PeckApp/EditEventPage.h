//
//  EditEventPage.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 7/1/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CampusEventsViewController.h"
#import "inviteFriends.h"
#import "ActionSheet.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

NSString *newShareText;
@interface EditEventPage : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MFMailComposeViewControllerDelegate,UIAlertViewDelegate>
{
    ASIFormDataRequest *listoflocation;
    ASIFormDataRequest *viewprofile;
    ASIFormDataRequest *eventdetails;
    ASIFormDataRequest *subscribeevents;
    ASIFormDataRequest *updateevents;
    ASIFormDataRequest *deleteevents;
    
    CGSize titleSize;
      NSMutableArray *eventcount;
    NSMutableArray  *weekList;
    NSMutableArray  *eventList;
    UITapGestureRecognizer   *singleTap;
    UIDatePicker *timePicker;
    UIDatePicker *datePicker;
    UIPickerView *weekPicker;
    UIPickerView *eventCategoryPicker;
    NSMutableArray  *locationList;
    NSMutableArray  *tableArray;
    BOOL selectPicker;
    CGSize myStringSize;
     NSString *newShareText;
    NSString *timetofill;
    NSString *datetofill;
    NSString *daytofill;
    NSString *eventcategory;
    NSInteger categoryserial;
  
    
}


@property (strong, nonatomic) IBOutlet UIButton *EventImageButton;

@property (strong, nonatomic) IBOutlet UIView *TimeandDateTitleView;

@property (strong, nonatomic) IBOutlet UIButton *updateEvent;


@property (strong, nonatomic) IBOutlet UILabel *eventDateTitleLabel;
@property (strong, nonatomic) IBOutlet UITextField *eventTitle;
@property (strong, nonatomic) IBOutlet UILabel *username;

@property (strong, nonatomic) IBOutlet UILabel *titleUsername;

@property (strong, nonatomic) IBOutlet UILabel *titleTime;

@property (strong, nonatomic) IBOutlet UIView *dateTitle;
@property (strong, nonatomic) IBOutlet UIView *readmorebuttonview;
@property (strong, nonatomic) IBOutlet UIButton *readmoreTitleButton;
@property (strong, nonatomic) IBOutlet UIScrollView *Backgroundscroller;
@property (strong, nonatomic) IBOutlet UITextView *commentTextView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIButton *readmoreButton;
@property (strong, nonatomic) IBOutlet UIImageView *eventImage;
@property (strong, nonatomic) IBOutlet UIButton *eventCategoryButton;

@property (strong, nonatomic) IBOutlet UIButton *inviteFriendsButton;
@property (strong, nonatomic) IBOutlet UILabel *ProfileName;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) IBOutlet UITextField *locationTextField;
@property (strong, nonatomic) IBOutlet UIButton *dateButton;

@property (strong, nonatomic) IBOutlet UIButton *weekButton;

@property (strong, nonatomic) IBOutlet UIButton *timeButton;
@property (strong, nonatomic) IBOutlet UIButton *buttonBgImage;
@property (strong, nonatomic)  ASIFormDataRequest *listoflocation;
@property (strong, nonatomic) ASIFormDataRequest *eventdetails;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;



-(IBAction)closeevent:(id)sender;
-(IBAction)inviteFriends:(id)sender;
- (IBAction)eventListPicker:(id)sender;
-(IBAction) timePicker:(id)sender;
- (IBAction)weekPicker:(id)sender;
- (IBAction)datePicker:(id)sender;
-(IBAction)selectPicture;
-(IBAction) readmore;

-(IBAction)updateevent:(id)sender;
-(IBAction)deleteevent:(id)sender;
@end
