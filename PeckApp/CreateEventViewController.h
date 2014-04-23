//
//  CreateEventViewController.h
//  PeckApp
//
//  Created by STPL MAC on 4/23/13.
//  Copyright (c) 2013 stpl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CampusEventsViewController.h"
#import "inviteFriends.h"
#import "ActionSheet.h"

@interface CreateEventViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    ASIFormDataRequest *createnewevent;
    ASIFormDataRequest *listoflocation;
    ASIFormDataRequest *viewprofile;
    IBOutlet UITextView *commentTextView;
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
    NSString *timetofill;
    NSString *datetofill;
    NSString *daytofill;
    NSString *eventcategory;

}
@property (strong, nonatomic) IBOutlet UIImageView *buttonImageView;
@property (strong, nonatomic) IBOutlet UIButton *eventCategoryButton;

@property (strong, nonatomic) IBOutlet UIButton *inviteFriendsButton;
@property (strong, nonatomic) IBOutlet UILabel *ProfileName;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UITextView *commentTextView;

@property (strong, nonatomic) IBOutlet UITextField *locationTextField;
@property (strong, nonatomic) IBOutlet UIButton *dateButton;

@property (strong, nonatomic) IBOutlet UIButton *weekButton;

@property (strong, nonatomic) IBOutlet UIButton *timeButton;
@property (strong, nonatomic) IBOutlet UITextField *EventTitle;
@property (strong, nonatomic) IBOutlet UIButton *buttonBgImage;

-(IBAction)createevent:(id)sender;
-(IBAction)closeevent:(id)sender;
-(IBAction)inviteFriends:(id)sender;
- (IBAction)eventListPicker:(id)sender;
-(IBAction) timePicker:(id)sender;
- (IBAction)weekPicker:(id)sender;
- (IBAction)datePicker:(id)sender;
-(IBAction)selectPicture;
@end
