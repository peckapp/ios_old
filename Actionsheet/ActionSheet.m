//
//  ActionSheet.m
//  Wo.iPhone
//
//  Created by pdixit on 04/12/12.
//  Copyright (c) 2012 pdixit. All rights reserved.
//

#import "ActionSheet.h"
#import "AppDelegate.h"


@interface ActionSheet ()
{
    
}
@property (nonatomic,copy) ActionSheetCompletionBlock callback;

@end
@implementation ActionSheet
@synthesize callback;


static ActionSheet *actionSheetDelegate;
+(void) initialize
{
    actionSheetDelegate = [[ActionSheet alloc] init];
}
+(void)showActionSheet:(NSString*)title :(NSArray *)buttons :(UIView*) view :(ActionSheetCompletionBlock) callback
{
    
     UIActionSheet * actionSheet = [[UIActionSheet alloc] init];

    //actionSheet =
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    //actionSheet.callback = callback;
    for (int i=0; i<buttons.count; i++)
    {
        [actionSheet addButtonWithTitle: [buttons objectAtIndex:i]];
    }
    
    
    //delegate = [[ActionSheet alloc] init];
    actionSheet.delegate = actionSheetDelegate; // delegate is an assign property, hence it needs to be allocated & retained. Hence it is a static instance..
    actionSheetDelegate.callback =  callback ;//autorelease];
   
    /*delegate.callback = ^(NSInteger buttonIndex) {
        callback(buttonIndex);
        actionSheet.delegate = nil;
        delegate = nil;
    };*/
     //[actionSheet  showFromTabBar:[AppDelegate current].mainMenu.tabVC.tabBar];
    //[actionSheet show]
    [actionSheet showInView:view];
    //[actionSheet release];
    
}

#pragma mark UIActionsheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
   // NSLog (@"Action sheet button clicked");
    callback(buttonIndex);
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    actionSheetDelegate.callback = nil;
    
}


@end
