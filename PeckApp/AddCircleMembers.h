//
//  AddCircleMembers.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 9/9/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "AppDelegate.h"
#import "ViewProfile.h"



@interface AddCircleMembers : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    ASIFormDataRequest *listofevents;
    ASIFormDataRequest *addnewcircle;
    ASIFormDataRequest *invitefriends;
    NSMutableArray  *eventcount;
    UITapGestureRecognizer  *singleTap;
    NSMutableArray * tableArray;
    UIActivityIndicatorView *activityIndicator;
    NSIndexPath *buttonindexpath;
    NSString *status;
    NSString *departmentid;
    NSMutableArray *tickCircleCount;
    NSMutableArray *saveeventcount;
    NSInteger startindex;
    NSInteger savestartindex;
}

@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) ASIFormDataRequest *listofevents;
@property (strong, nonatomic) NSMutableArray  *eventcount;
@property (strong, nonatomic) IBOutlet UITextField *findPersonOrGroup;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;

-(IBAction) addMembersDone:(id)sender;
-(IBAction) addMembersCancel:(id)sender;


@end
