//
//  ViewCircles.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 6/7/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "AppDelegate.h"
#import "ViewProfile.h"
#import "AddCircleMembers.h"

@interface ViewCircles : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
  ASIFormDataRequest *listofevents;
    ASIFormDataRequest *deletecircle;
   NSMutableArray  *eventcount;
    NSInteger  startindex;
    NSInteger savestartindex;
    CGSize titleSize;
    BOOL selfcircle;
    NSIndexPath *circleindexpath;
}
@property (strong, nonatomic) IBOutlet UIButton *addNewmembersButton;
@property (strong, nonatomic) IBOutlet UIButton *readmoreTitleButton;

@property (strong, nonatomic) IBOutlet UIView *profileImageView;
@property (strong, nonatomic) IBOutlet UIView *circleImageView;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *circletitle;
@property (strong, nonatomic) IBOutlet UIImageView *circleImage;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *ProfileName;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;

-(IBAction) closeViewCircle:(id)sender;
-(IBAction) addMemberscircle:(id)sender;
@end
