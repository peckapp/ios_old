//
//  Circles.h
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/7/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateCircle.h"
#import "HomeScreen.h"
#import "ViewCircles.h"

@class HomeScreen;
     
@interface Circles : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    HomeScreen *homescreen;
    CGRect frame;
    BOOL menuOpen;
    ASIFormDataRequest *listofevents;
     ASIFormDataRequest *deletecircle;
    NSMutableArray  *eventcount;
    NSMutableArray *tableArray;
    UITapGestureRecognizer  *singleTap;
     NSInteger startindex;
     NSInteger savestartindex;
    UIButton *menuclickbutton;
    NSIndexPath *circleindexpath;

}
@property (strong, nonatomic)   NSMutableArray  *eventcount;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (assign) BOOL menuOpen;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UITextField *findPersonOrGroup;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;


- (IBAction)closeCircles:(id)sender;
- (IBAction)createCircles:(id)sender;
-(IBAction)circlesClosed:(id)sender;
@end
