//
//  ForumPage.h
//  PeckApp
//
//  Created by STPLINC. on 5/13/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "AppDelegate.h"
#import "PullTableViewFooter.h"

#define MaxCharacterLength 80


@interface ForumPage : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,PullTableViewFooterDelegate>
{
    ASIFormDataRequest *listofevents;
     ASIFormDataRequest *postcomments;
    NSInteger startindex;
    NSMutableArray  *eventcount;
    UITapGestureRecognizer  *singleTap;
    CGSize titleSize;
    NSInteger savestartindex;
}
@property (strong, nonatomic) IBOutlet UIImageView *nocommentImage;
@property (strong, nonatomic) IBOutlet UILabel *fakeMessage;
@property (strong, nonatomic) IBOutlet UIButton *readmoreTitleButton;
@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
 @property(strong,nonatomic)   NSMutableArray  * eventcount;
@property (strong, nonatomic) IBOutlet UIView *forumCommentView;
@property (strong, nonatomic) IBOutlet UITextField *forumComment;
@property (strong, nonatomic) PullTableViewFooter *tableview;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;
-(IBAction) writeComment:(id)sender;
-(IBAction)forumPageClosed:(id)sender;
- (IBAction)keyboardhidden:(id)sender;
-(IBAction) readmoreTitle:(id)sender;


@end
