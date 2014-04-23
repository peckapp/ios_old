//
//  AboutUs.m
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 7/10/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "AboutUs.h"

@interface AboutUs ()

@end

@implementation AboutUs

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)aboutusclose:(id)sender
{
     [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction) openmail:(id)sender
{
 Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));   
    if (mailClass != nil) {
 MFMailComposeViewController *mailComposeViewController=[[MFMailComposeViewController alloc] init];
  mailComposeViewController.mailComposeDelegate=self;
  [mailComposeViewController setSubject:@"Feedback"];
 [mailComposeViewController setToRecipients:[NSArray arrayWithObjects:@"peckapp.team@gmail.com",nil]];
        if([mailClass canSendMail]) {
         [self presentViewController:mailComposeViewController animated:YES completion:nil];
           //[self presentModalViewController:mailComposeViewController animated:YES];
        }
        
    }
  
}
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
   [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(IBAction) openpeckurl:(id)sender
{
    PeckView *pv=[[PeckView alloc] initWithNibName:@"PeckView" bundle:nil];
    [self.navigationController pushViewController:pv animated:YES];
 
}


- (void)viewDidLoad
{
    [super viewDidLoad];
      self.HeaderTitle.font = [UIFont boldSystemFontOfSize:self.HeaderTitle.font.pointSize];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setHeaderTitle:nil];
   
    [super viewDidUnload];
}
@end
