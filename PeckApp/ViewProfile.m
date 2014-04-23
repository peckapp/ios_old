//
//  ViewProfile.m
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 6/10/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

//
//  Profile.m
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/9/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "ViewProfile.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewProfile

@synthesize profileImage,emailid,username,twittername,aboutDescription;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark Tweet

- (IBAction)tweetTapped:(id)sender
{
    if (![self.twittername.text isEqual:@""])
    {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            NSString *newstring =  [self.twittername.text
                                    stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            
            if  (![newstring hasPrefix:@"@"])
            {
                newstring = [NSString stringWithFormat:@"@%@",newstring];
            }
            
            [tweetSheet setInitialText:[NSString stringWithFormat:@"%@ \n",newstring]];

            [self presentViewController:tweetSheet animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:alertTitle
                                      message:@"You can't send a tweet right now, make sure your device has an internet connection and you have atleast one Twitter account setup."
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
            [alertView show];
        }

    }
    
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:alertTitle
                                  message:@"Twitter name is not Available."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }

    
    }


#pragma mark Open Email

-(IBAction) openmail:(id)sender
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil) {
        MFMailComposeViewController *mailComposeViewController=[[MFMailComposeViewController alloc] init];
        mailComposeViewController.mailComposeDelegate=self;
        //[mailComposeViewController setMessageBody:newShareText isHTML:YES];
        [mailComposeViewController setToRecipients:[NSArray arrayWithObjects:self.emailid.text,nil]];
        if([mailClass canSendMail]) {
             [self presentViewController:mailComposeViewController animated:YES completion:nil];
           // [self presentModalViewController:mailComposeViewController animated:YES];
        }
        
    }
    
}
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

# pragma mark Phone Call 
- (IBAction) phonecall:(id)sender
{
UIDevice *device = [UIDevice currentDevice];
if ([[device model] isEqualToString:@"iPhone"] )
{
    if (![self.phoneno.text isEqual:@""])
    {
        NSString *phoneno  = [self.phoneno.text stringByReplacingOccurrencesOfString:@"(" withString:@""];
        phoneno  = [phoneno stringByReplacingOccurrencesOfString:@")" withString:@""];
        phoneno  = [phoneno stringByReplacingOccurrencesOfString:@"-" withString:@""];

        DLog(@"ph=%@",phoneno);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phoneno]]];

    }
    
    else
    {
    
     [[[UIAlertView alloc] initWithTitle:alertTitle message:@"Phone No. is not available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
    }
   }
else
{
    [[[UIAlertView alloc] initWithTitle:alertTitle message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
  
}


}

-(void)viewWillAppear:(BOOL)animated
{
      
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    if (appDel.enterscreen)
    {

        [appDel addLoaderForViewController:self];
      self.HeaderTitle.font = [UIFont boldSystemFontOfSize:self.HeaderTitle.font.pointSize];
        viewprofile =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:fbuserprofile_details]] ;
        [viewprofile setDelegate:self];
        [viewprofile setPostValue:appDel.profileid forKey:@"userid"];
        [viewprofile  startAsynchronous];
    self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
    self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
    
    self.imageCache = [[NSCache alloc] init];
    }
}


-(void) viewDidAppear:(BOOL)animated
{
 AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterscreen=FALSE;
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    
    if (request==viewprofile)
    {
        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
        dict = [dict dictionaryByReplacingNullsWithStrings];
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
        //  NSString *status=[dict valueForKey:@"status"];
        self.username.text=[dict valueForKey:@"username"];
        self.emailid.text=[dict valueForKey:@"email"];
        self.phoneno.text=[dict valueForKey:@"phoneno"];
        self.twittername.text=[dict valueForKey:@"tname"];
        //   if ([dict valueForKey:@"about_me"]!=nil) {
        self.aboutDescription.text=[dict valueForKey:@"about_me"];
        // }
    
        
        [appDel removeLoader];
        
        NSString *imageurl= [dict valueForKey:@"profile_image"];
        imageurl = [imageurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
       if (![imageurl isEqual:@""])
        {

        UIImage *cachedImage = [self.imageCache objectForKey:imageurl];
        
        if (cachedImage)
        {
            self.profileImage.image = cachedImage;
        }
        else
        {
            // you'll want to initialize the image with some blank image as a placeholder
            UIActivityIndicatorView *eventimageloading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            eventimageloading.center = CGPointMake(self.profileImage.frame.size.width/2, self.profileImage.frame.size.height/2);
            eventimageloading.alpha = 1.0;
            eventimageloading.hidesWhenStopped = YES;
            [eventimageloading startAnimating];
            [self.profileImage addSubview:eventimageloading];
            
            
            // now download in the image in the background
            
            [self.imageDownloadingQueue addOperationWithBlock:^{
                
                NSURL *imageUrl   = [NSURL URLWithString:imageurl];
                NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
                UIImage *image    = nil;
                if (imageData)
                    image = [UIImage imageWithData:imageData];
                
                if (image)
                {
                    // add the image to your cache
                    
                    [self.imageCache setObject:image forKey:imageurl];
                    
                    // finally, update the user interface in the main queue
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        // make sure the cell is still visible
                        
                        
                        UIImage  *i = [ImageHelper imageByScalingProportionallyToSize:CGSizeMake(image.size.width, image.size.height):image];
                        profileImage.image = i;
                    }];
                }
                [eventimageloading removeFromSuperview];
                [eventimageloading stopAnimating];

                
            }];
            
        }
        }
    }
        
        else   if ([[dict objectForKey:@"status"] isEqual:@"e"])
        {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            [appDel removeLoader];
        }
        
        else if (dict==nil)
        {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            [appDel removeLoader];
            
        }
  
    }
    
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
   // NSString *response  =  [request responseString];
   // DLog(@"response=%@",response);
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
    
    
}


- (IBAction)closeProfile:(id)sender
{
   
        [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.profileImage.layer.cornerRadius=30.0;
    self.profileImage.layer.masksToBounds = YES;
    self.profileImage.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.profileImage.layer.borderWidth=1.0;
    
}

- (void)viewDidUnload
{
    [self setProfileImage:nil];
    [self setEmailid:nil];
    [self setUsername:nil];
    [self setPhoneno:nil];
    [self setAboutDescription:nil];
 
    [self setHeaderTitle:nil];
    [self setEmailid:nil];
    [self setUsername:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)emailid:(id)sender {
}
@end
