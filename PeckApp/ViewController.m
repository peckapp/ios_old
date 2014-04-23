//
//  ViewController.m
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/3/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "ViewController.h"
#import "Webservices.h"

@implementation ViewController

@synthesize Backgroundscroller;




-(IBAction)loginscreen:(id)sender
{

    Login *loginscreen=[[Login alloc] initWithNibName:@"Login" bundle:nil];
    
    [self.navigationController pushViewController:loginscreen animated:YES];

}


-(IBAction)registrationscreen:(id)sender{

   Registration *registrationscreen=[[Registration alloc] initWithNibName:@"Registration" bundle:nil];
    
    [self.navigationController pushViewController:registrationscreen animated:YES];


}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)viewWillAppear:(BOOL)animated
{
     //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(facebookLoginServerRequest:) name:@"FacebookUserDetails" object:nil];
  

}

- (void)viewDidLoad
{
    [super viewDidLoad];
      [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.Backgroundscroller.delegate=self;
   // self.Backgroundscroller.contentSize=CGSizeMake(0, 610);
        
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidUnload
{
    [self setBackgroundscroller:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




- (void)viewWillDisappear:(BOOL)animated
{
	
      [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end
